//---------------------------------------------------------------------------------
//file name -> counter_env.sv
//claass    -> counter_env
//methods   -> new
//description -> This class is container which is having agents, predictor and
//scoreboard
//---------------------------------------------------------------------------------
typedef class counter_virtual_sequencer;

class counter_env extends uvm_env;

  //declare virtual interfaces
  virtual counter_inf vif1;
  virtual counter_inf vif2;

  //handle of virtual sequencer
  counter_virtual_sequencer m_vseqr;

  //----------------------------------------------------------
  // component declaration
  // ---------------------------------------------------------

  // handle of the counter agent
  counter_agent m_agent[number];

  //handle of counter scoreboard
  counter_scoreboard m_scoreboard;

  //handle of the counter predictor
  counter_predictor m_predictor;

  uvm_analysis_port#(counter_ref_trans)pre_sco[n];   

  //------------------------------------------------------------
  //UVM factory registration
  //------------------------------------------------------------
  `uvm_component_utils(counter_env)

  //----------------------------------------------------------
  //function -> new
  //arguments -> string name    
  //desccription -> constructor for environment
  //---------------------------------------------------------
  function new(string name = "counter_env",uvm_component parent);
    super.new(name,parent);
  endfunction : new  

  //---------------------------------------------------------
  //function  ->  build phase
  //arguments -> handle of UVM_phase
  //description -> In this phase all the class objects are created
  //---------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    for(int i=0; i<number;i++)begin
      `uvm_info("",$sformatf("Agent[%0d] is created", i),UVM_HIGH)
      m_agent[i] = counter_agent::type_id::create($sformatf("m_agent[%0d]",i),this);
    end

    m_scoreboard= counter_scoreboard::type_id::create("m_scoreboard",this);
    m_predictor = counter_predictor::type_id::create("m_predictor",this);
  
    m_vseqr      = counter_virtual_sequencer::type_id::create("m_vseqr",this);

    `uvm_info("",$sformatf("scoreboard is build in environment %p",m_scoreboard),UVM_HIGH)

    if(!uvm_config_db#(virtual counter_inf)::get(this,"","vif1",vif1))begin
      `uvm_fatal(get_full_name(),{"virtual interface must be set for env:","vif1"});  //Method get
      end
    
    if(!uvm_config_db#(virtual counter_inf)::get(this,"","vif2",vif2))begin
      `uvm_fatal(get_full_name(),{"virtual interface must be set for env:","vif2"});  //Method get
      end

    uvm_config_db#(virtual counter_inf)::set(this,"m_agent[0]*","vif",vif1);  //set for agent 1
    uvm_config_db#(virtual counter_inf)::set(this,"m_agent[1]*","vif",vif2);  //set for agnet 2

  endfunction : build_phase

  //--------------------------------------------------------------------------
  //function -> connect_phase
  //arguments -> handle of UVM_phase
  //description -> connections between different counter environment
  //               components
  //-------------------------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_vseqr.m_env = this;

    for(int i=0; i<number;i++)begin
      m_vseqr.m_seqr[$sformatf("%0d",i)] = m_agent[$sformatf("%0d",i)].m_sequencer;
      m_vseqr.m_seqr[i] = m_agent[i].m_sequencer;
    end

    for(int i=0;i<number;i++)begin
      m_agent[i].m_monitor.mon_pre.connect(m_predictor.mon_pre[i].analysis_export);
    end       
       
    for(int i=0;i<number;i++)begin
      m_agent[i].m_monitor.mon_sco.connect(m_scoreboard.mon_sco[i].analysis_export);
    end
     
    for(int i=0;i<number;i++)begin
      m_predictor.pre_sco[i].connect(m_scoreboard.pre_sco[i].analysis_export);
    end

  endfunction

  //-------------------------------------------------------------------
  //Task -> reset
  //Arguments -> uvm_phase phase- handle of UVM_phase
  //description -> apply reset as per time delay  by argument method
  //------------------------------------------------------------------
  virtual task start_reset(time rst_time); 

    vif2.reset = 1'b1;
    `uvm_info("",$sformatf("-------*********---------------------reset is applied-------------**********-----------"),UVM_LOW);

    //delay be arguments
    #(rst_time);

    //removing reset by applying 0
    vif2.reset = 1'b0;
   
    `uvm_info("",$sformatf("--------********---------------------reset is removed--------------**********----------"),UVM_LOW);
    
  endtask : start_reset

endclass : counter_env
