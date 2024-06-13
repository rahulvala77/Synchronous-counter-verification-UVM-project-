//------------------------------------------------------------
//file name -> counter_monitor.sv
//claass    -> counter_monitor
//methods   -> new
//description -> this component is used to monitor data from DUT
//----------------------------------------------------------
class counter_monitor extends uvm_monitor;

  //UVM factory registration
  `uvm_component_utils(counter_monitor)

  //declaring virtual interface
  virtual counter_inf.MON_MP vif;

  //declaring analysis port  
  uvm_analysis_port#(counter_trans)mon_sco;
  uvm_analysis_port#(counter_trans)mon_pre;

  //create the trans class handle;
  counter_trans m_trans;
  
  //-----------------------------------------------------------
  //function -> new
  //arguments -> string name
  //description -> constructor for monitor
  //-----------------------------------------------------------
  function new(string name = "counter_monitor", uvm_component parent);
    super.new(name,parent);
    mon_sco = new ("mon_sco",this);
    mon_pre = new ("mon_pre",this);
  endfunction : new

  //----------------------------------------------------------
  //function -> build phase
  //arguments ->  uvm phase
  //description ->  class objects are created
  //----------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_trans = counter_trans::type_id::create("m_trans");
  endfunction

  //----------------------------------------------------------------
  //method -> monitor
  //argument -> NONE
  //description ->  get the data from interface
  //----------------------------------------------------------------
   task monitor();
    @(vif.mon_cb);
      m_trans.enable   = vif.mon_cb.enable;
      m_trans.updown   = vif.mon_cb.updown;
      m_trans.load     = vif.mon_cb.load;
      m_trans.data_in  = vif.mon_cb.data_in;
      m_trans.data_out = vif.mon_cb.data_out;
  endtask : monitor

  //----------------------------------------------------------------------
  //task -> run
  //arguments -> NONE
  //descriprion -> saamples data from interface and send to predictor and
  //               scoreboard
  //---------------------------------------------------------------------               
  task run();
    `uvm_info("MONITOR", "WE ARE IN MONITOR", UVM_HIGH);
    monitor();
    mon_sco.write(m_trans); //from monitor to scoreboard 
    mon_pre.write(m_trans); //from monitor to predictor
 
  endtask
  //----------------------------------------------------------------------
  //task -> run_phase
  //arguments -> uvm_phase
  //description -> this phase in which all class methods are started
  //----------------------------------------------------------------------
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      run();
    end
  endtask : run_phase

endclass : counter_monitor  
