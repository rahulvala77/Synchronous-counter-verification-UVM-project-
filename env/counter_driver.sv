//------------------------------------------------------------
//file name -> counter_driver.sv
//claass    -> counter_driver
//methods   -> new
//description -> this component is used to drive data to DUT
//-----------------------------------------------------------
class counter_driver extends uvm_driver #(counter_trans);
  
  //---------------------------------------------------------
  //UVM factory registration
  //---------------------------------------------------------
  
  `uvm_component_utils(counter_driver)

  //declaring virtual interface
  virtual counter_inf.DRV_MP vif;

  //declaring transaction class handle
  counter_trans req;

  //----------------------------------------------------------
  //function -> new
  //arguments -> string name    
  //desccription -> constructor for driver
  //---------------------------------------------------------
  function new(string name = "counter_driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //-----------------------------------------------------------
  //function -> build_phase
  //arguments -> uvm_phase phase
  //description -> class objects are created
  //-----------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  //----------------------------------------------------------
  //Task -> run_phase
  //arguments -> uvm_phase
  //description -> send data to interface
  //---------------------------------------------------------
  task data_to_dut(counter_trans req);
    @(vif.drv_cb);  
    vif.drv_cb.enable <= req.enable;
    vif.drv_cb.updown <= req.updown;
    vif.drv_cb.load <= req.load;
    vif.drv_cb.data_in <= req.data_in;

  endtask : data_to_dut
  //----------------------------------------------------------
  //Task -> run_phase
  //arguments -> uvm_phase
  //description -> this task run by environment
 //---------------------------------------------------------
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      data_to_dut(req);
      seq_item_port.item_done();
    end
  endtask : run_phase

endclass : counter_driver
