//------------------------------------------------------------
//file name -> counter_predictor.sv
//claass    -> counter_predictor
//methods   -> new
//description -> this component is used to generate expected data
//-----------------------------------------------------------
class counter_predictor extends uvm_component;

  //UVM factory registration
  `uvm_component_utils(counter_predictor)

  //declare transactionn class handle
  counter_trans m_trans[n];

  //declare uvm tlm analysis fifo
  uvm_analysis_port#(counter_ref_trans)pre_sco[n];

  //declare uvm tlm analysis fifo
  uvm_tlm_analysis_fifo#(counter_trans)mon_pre[n];

  //declaration of reference model transaction class
  counter_ref_trans m_ref_trans[n];
  
  //declaration of virtual interfce handle to connect reset
  virtual counter_inf vif;
  
  //local variable declaration 
  bit rst_status;
  time rst_assert,rst_deassert;  

  //------------------------------------------------------------------
  //function :-> new
  //arguments :-> sterig name and name of object
  //
  //declaration :-> construction of counter reference model
  //------------------------------------------------------------------
  function new(string name = "counte_predictor",uvm_component parent);
    super.new(name,parent);
    for(int i=0; i<n;i++) begin
      mon_pre[i] = new($sformatf("mon_pre[%0d]",i),this);
    end

    for(int i=0; i<n;i++) begin
      pre_sco[i] = new($sformatf("pre_sco[%0d]",i),this);
    end
    
  endfunction : new

  //-------------------------------------------------------------
  //function :-> build_phase
  //arguments :-> uvm_phase : declare handle of uvm phase
  //
  //declaration :-> INn this phasse all class objects are made
  //------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    for(int i=0;i<n;i++) begin
      m_ref_trans[i] = counter_ref_trans::type_id::create($sformatf("m_ref_trans[%0d]",i),this);
      m_trans[i]     = counter_trans::type_id::create($sformatf("m_trans[%0d]",i),this);
    end

    if(!uvm_config_db#(virtual counter_inf)::get(this,"","vif2",vif)) 
      `uvm_fatal("VIF config", "can not get interface vif1 from uvm_config_db")
    
  endfunction : build_phase

  //-------------------------------------------------------------
  //function :-> predictor
  //arguments :-> NA
  //declaration :-> sample design of predictor
  //------------------------------------------------------------
  function void predictor();
    for(int i=0; i<n; i++)begin
      if(/*vif.reset == 1 && */(m_ref_trans[i].rst_width >= 20))begin
        m_ref_trans[i].temp_data_out = 1'd0;
        m_ref_trans[i].temp_data_in = m_trans[i].data_in;
        m_ref_trans[i].temp_load   = m_trans[i].load;
        m_ref_trans[i].temp_enable = m_trans[i].enable;
        m_ref_trans[i].temp_updown = m_trans[i].updown;
        `uvm_info("","first condition of predictor", UVM_HIGH);
      end

      else if((m_trans[i].enable == 1) && (m_trans[i].load ==1))begin
        m_ref_trans[i].temp_data_out = m_trans[i].data_in;
        m_ref_trans[i].temp_data_in = m_trans[i].data_in;
        m_ref_trans[i].temp_load   = m_trans[i].load;
        m_ref_trans[i].temp_enable = m_trans[i].enable;
        m_ref_trans[i].temp_updown = m_trans[i].updown;
      
        `uvm_info("","second condition of predictor",UVM_HIGH);
        `uvm_info("",$sformatf("m_trans[%0d].data_in = %0d : %0d = m_ref_trans[%d].temp_out_data",i, m_trans[i].data_in,m_ref_trans[i].temp_data_out,i),UVM_HIGH);
      end
      else if((m_trans[i].enable == 1) && (m_trans[i].load == 1'b0) && (m_trans[i].updown == 1'b1)) begin
        m_ref_trans[i].temp_data_out = m_ref_trans[i].temp_data_out + 1'b1;
        m_ref_trans[i].temp_data_in = m_trans[i].data_in;
        m_ref_trans[i].temp_load   = m_trans[i].load;
        m_ref_trans[i].temp_enable = m_trans[i].enable;
        m_ref_trans[i].temp_updown = m_trans[i].updown;

        `uvm_info("","Third condition  of predictor",UVM_HIGH);
      end

      else if((m_trans[i].enable ==1) && (m_trans[i].load == 1'b0) && (m_trans[i].updown ==1'b0))begin
        m_ref_trans[i].temp_data_out = m_ref_trans[i].temp_data_out - 1'b1;
        m_ref_trans[i].temp_data_in = m_trans[i].data_in;
        m_ref_trans[i].temp_load   = m_trans[i].load;
        m_ref_trans[i].temp_enable = m_trans[i].enable;
        m_ref_trans[i].temp_updown = m_trans[i].updown;

        `uvm_info("","Fourth condition  of predictor",UVM_HIGH);
      end

      else if (m_trans[i].enable == 0 && ((m_trans[i].load == 1) || (m_trans[i].load == 0)) && ((m_trans[i].updown == 1) || (m_trans[i].updown == 0)) )begin
        m_ref_trans[i].temp_data_out = m_ref_trans[i].temp_data_out;
        m_ref_trans[i].temp_data_in = m_trans[i].data_in;
        m_ref_trans[i].temp_load   = m_trans[i].load;
        m_ref_trans[i].temp_enable = m_trans[i].enable;
        m_ref_trans[i].temp_updown = m_trans[i].updown;
      
      end
   end
  endfunction :predictor

  //----------------------------------------------------------------------
  //task :-> run 
  //description:-> get the data from monitor and generate predictor output
  //----------------------------------------------------------------------
  task run();
    begin
      for(int i=0; i<n; i++) begin
        mon_pre[i].get(m_trans[i]);
      end
      
      predictor();           

      for(int i=0; i<n; i++) begin
        pre_sco[i].write(m_ref_trans[i]);
      end

    end
  endtask :run

  task predict_reset_widh ();
    forever begin
      @(vif.reset);
      // posdge
      if ((vif.reset == 1) && (rst_status == 0)) begin
        rst_status = 1;
        rst_assert = $time;
      end
      // negedge
      if ((vif.reset == 0) && (rst_status == 1)) begin
        rst_status = 0;
        rst_deassert = $time;
      end
      if (rst_deassert > rst_assert) begin
        m_ref_trans[0].rst_width = rst_deassert - rst_assert;
        m_ref_trans[1].rst_width = rst_deassert - rst_assert;
        $display("rst_width : %0d, time : %0t", m_ref_trans[0].rst_width,$time);
        {rst_deassert,rst_assert} = 'd0;
      end
    end
  endtask

  //---------------------------------------------------------------------
  //task:-> run_phase 
  //arguments:-> uvm_phase phase : handle delaration
  //description:-> from this phase all tasks are called
  //--------------------------------------------------------------------
  virtual task run_phase(uvm_phase phase);
    fork
      forever begin
        run();
      end
      begin
        predict_reset_widh();
      end
    join
  endtask : run_phase

endclass : counter_predictor

