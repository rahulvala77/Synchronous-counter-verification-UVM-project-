//----------------------------------------------------------------------------------------------
//file-name -> counter_agent.sv
//class     -> couter_agent
//methods   -> new
//description -> this component is uder to connect monitor , sequencer, driver within
//----------------------------------------------------------------------------------------------
class counter_agent extends uvm_agent;

  //uvm factory registration
  `uvm_component_utils(counter_agent)

  //declaring virtual interface
  virtual counter_inf vif_counter;

  //-------------------------------------------------------------------
  //component declaring
  //-------------------------------------------------------------------
  //Handle of driver
  counter_driver m_driver;

  //handle of sequencer
  counter_sequencer m_sequencer;

  //handle of the counter monitor
  counter_monitor m_monitor;

  //handle of the config class
  counter_config m_cfg;

  //-------------------------------------------------------------------
  //function  -> new
  //arguments -> string name
  //description -> constructor for counter agent
  //------------------------------------------------------------------
  function new(string name = "counter_agent", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  //------------------------------------------------------------------
  //function -> build_phase
  //arguments -> uvm_phase
  //description -> this phase create all the components of counter agent
  //------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create config class
    m_cfg=counter_config::type_id::create("m_cfg",this);
     
    if(!uvm_config_db#(virtual counter_inf)::get(this,"","vif",vif_counter))begin
          `uvm_fatal(get_full_name(),{"virtual interface must be set for : ",".vif_counter"}); //get method
        end

    if(m_cfg.is_active == UVM_ACTIVE) begin

      //create the counter driver
      m_driver = counter_driver::type_id::create("m_driver",this); 

      //create the counter sequencer
      m_sequencer= counter_sequencer::type_id::create("m_sequencer",this);   

      end
      //create the counter monitor
      m_monitor = counter_monitor::type_id::create("m_monitor",this);

  endfunction : build_phase

  //-------------------------------------------------------------------------
  //function -> connect_phase
  //arguments -> uvm_phase
  //description -> tihs connects all components inside agent
  //------------------------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

  if(m_cfg.is_active == UVM_ACTIVE) begin
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    m_driver.vif = vif_counter;

  end

  m_monitor.vif = vif_counter;

  endfunction : connect_phase

endclass : counter_agent
