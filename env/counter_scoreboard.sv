//------------------------------------------------------------
//file name -> counter_scoreboard.sv
//claass    -> counter_scoreboard
//methods   -> new
//description -> this component is used to compare actual and expected data
//and do sampling for coverage
//-----------------------------------------------------------
class counter_scoreboard extends uvm_scoreboard;

  //uvm factory registration
  `uvm_component_utils(counter_scoreboard)

  //transaction class handle
  counter_trans m_trans[n];

  //coverage handle
  up_down_coverage m_cov[n] ;

  //uvm_tlm analysis fifo declaration
  uvm_tlm_analysis_fifo#(counter_trans)mon_sco[n];

  //declare uvm tlm analysis fifo
  uvm_tlm_analysis_fifo#(counter_ref_trans)pre_sco[n];

  //declaration of reference model transaction class
  counter_ref_trans m_ref_trans[n];
   
  //interface handle
  virtual counter_inf vif;

  //temp_variable_declaration to hold previous value
  bit [7:0] prev_data_out [1:0] ;

  //---------------------------------------------------------------------------
  //function:-> new
  //aruments:-> string name : name of object
  //description :-> counter_scoreboard construction
  //--------------------------------------------------------------------------
  function new(string name = "counter_scoreboard", uvm_component parent);
    super.new(name,parent);

    for(int i=0;i<n;i++)begin
      mon_sco[i]= new($sformatf("mon_sco[%0d]",i),this);
      `uvm_info("",$sformatf("BUILD phase of SCOREBOARD %0d %0p", i, mon_sco[i]),UVM_HIGH)
    end

    for(int i=0;i<n;i++)begin
      pre_sco[i]= new($sformatf("pre_sco[%0d]",i),this);
      `uvm_info("",$sformatf("BUILD phase of SCOREBOARD %0d %0p", i, pre_sco[i]),UVM_HIGH)
    end

  endfunction : new

  //--------------------------------------------------------------------------
  //function :-> build phase
  //arguents :-> uvm_phase phase : handle of uvm_phase
  //description : -> all class objects are created in this phase
  //--------------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    for(int i=0;i<n;i++)begin
    m_cov[i] = up_down_coverage::type_id::create($sformatf("m_cov[%0d]",i),this);
    end

    for(int i=0;i<n;i++)begin
      m_trans[i] = counter_trans::type_id::create($sformatf("m_trans[%0d]",i),this);
    end

    for(int i=0;i<n;i++)begin
      m_ref_trans[i] = counter_ref_trans::type_id::create($sformatf("m_ref_trans[%0d]",i),this);
    end    

    if(!uvm_config_db#(virtual counter_inf)::get(this,"","vif2",vif)) 
    `uvm_fatal("VIF config", "can not get interface vif2 from uvm_config_db")
    
  endfunction : build_phase
  
  //-------------------------------------------------------------------------
  //task:-> run_phase
  //arguments :-> uvm_phase : handle declaration
  //description:-> sample interface and create transaction
  //------------------------------------------------------------------------
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);    
      forever begin
        run();
      end      
  endtask : run_phase

  //----------------------------------------------------------------------
  //task :-> run 
  //description:-> get the data from monitor and generate predictor output
  //----------------------------------------------------------------------
  task run();
    begin 
      fork
        for(int i=0; i<n; i++)begin
          mon_sco[i].get(m_trans[i]);
        end         

        for(int i=0 ; i<n ; i++) begin
          pre_sco[i].get(m_ref_trans[i]);
        end
      join        
      begin 
        `uvm_info("PREV VALUE", $sformatf("prev_data_out[0] = %d ", prev_data_out[0]),UVM_HIGH);
        `uvm_info("PREV VALUE", $sformatf("prev_data_out[1] = %d ", prev_data_out[1]),UVM_HIGH);
      end  
        compare_data();
         
        for(int i=0; i<n ; i++)begin
          `uvm_info("PREV VALUE", $sformatf("prev_data_out[%0d] = %0d, m_ref_trans[%0d].temp_data_out = %0d,m_ref_trans[%0d].temp_enable = %0d, m_ref_trans[%0d].temp_updown = %0d, reset= %0d ",i,prev_data_out[i],i,m_ref_trans[i].temp_data_out,i,m_ref_trans[i].temp_enable,i, m_ref_trans[i].temp_updown, vif.reset),UVM_LOW);
          m_cov[i].m_up_coverage.sample(m_ref_trans[i].temp_data_out,vif.reset,m_ref_trans[i].temp_load, m_ref_trans[i].temp_enable, m_ref_trans[i].temp_updown,prev_data_out[i]);
          m_cov[i].m_down_coverage.sample(m_ref_trans[i].temp_data_out,vif.reset,m_ref_trans[i].temp_load, m_ref_trans[i].temp_enable, m_ref_trans[i].temp_updown,prev_data_out[i]);
          m_cov[i].m_reset_coverage.sample(m_ref_trans[i].temp_data_out,vif.reset,m_ref_trans[i].rst_width);
          m_cov[i].m_rollover_coverage.sample(m_ref_trans[i].temp_data_out,vif.reset, m_ref_trans[i].temp_load, m_ref_trans[i].temp_enable, m_ref_trans[i].temp_updown,prev_data_out[i]);
          m_cov[i].m_rollback_coverage.sample(m_ref_trans[i].temp_data_out,vif.reset, m_ref_trans[i].temp_load, m_ref_trans[i].temp_enable, m_ref_trans[i].temp_updown,prev_data_out[i]);
          m_cov[i].m_up_down_coverage.sample(m_ref_trans[i].temp_data_out,vif.reset, m_ref_trans[i].temp_load, m_ref_trans[i].temp_enable, m_ref_trans[i].temp_updown,prev_data_out[i]);
          m_cov[i].m_load_coverage.sample(m_ref_trans[i].temp_data_in,m_ref_trans[i].temp_data_out,vif.reset, m_ref_trans[i].temp_load, m_ref_trans[i].temp_enable,m_ref_trans[i].temp_updown,prev_data_out[i]);
          m_cov[i].m_one_up_second_down_coverage.sample(m_ref_trans[i].temp_data_out,vif.reset, m_ref_trans[i].temp_load, m_ref_trans[i].temp_enable, m_ref_trans[i].temp_updown,prev_data_out[i]);
          m_cov[i].m_one_down_second_up_coverage.sample(m_ref_trans[i].temp_data_out,vif.reset, m_ref_trans[i].temp_load, m_ref_trans[i].temp_enable, m_ref_trans[i].temp_updown,prev_data_out[i]); 
        end          
     
    end
    begin 
      prev_data_out[0] = m_ref_trans[0].temp_data_out;
      prev_data_out[1] = m_ref_trans[1].temp_data_out;
    end  
  endtask

  //-------------------------------------------------------------
  //Task :-> compare_data
  //arguments:-> NA
  //description :-> interface and predicor data compared
  //-------------------------------------------------------------
  task compare_data();
    for(int i=0;i<n;i++)begin
    if(m_ref_trans[i].temp_data_out ==? m_trans[i].data_out)begin
      `uvm_info("PASS",$sformatf("check = %0d data_out_1 is matched <=> expected = %0d :: %0d = actual",i, m_ref_trans[i].temp_data_out,m_trans[i].data_out),UVM_LOW);    
      
    end
    else begin
      `uvm_error("FAIL",$sformatf("check = %0d data_out_1 is mismatch <=> expected = %0d :: %0d = actual",i, m_ref_trans[i].temp_data_out,m_trans[i].data_out));
    end
    end
  endtask 

endclass : counter_scoreboard 

