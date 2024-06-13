//------------------------------------------------------------------
//class:-> counter_virtual_sequencer
//method:-> new
//description:-> this is counter virtual sequencer
//------------------------------------------------------------------
typedef class counter_env;

class counter_virtual_sequencer extends uvm_sequencer;

  //declaration of sequencer handle
  counter_sequencer m_seqr[n];

  //declaration of handle of environment
  counter_env m_env;

  //uvm factory registration 
  `uvm_component_utils_begin(counter_virtual_sequencer)
    `uvm_field_object(m_env,UVM_ALL_ON)
  `uvm_component_utils_end

  //-----------------------------------------------------------------
  //fucntion:-> new
  //arguments:-> string name -name of object, uvm_component parent
  //description:-> constructor for counter_virtual_sequence
  //-----------------------------------------------------------------
  function new(string name = "counter_virtual_sequencer", uvm_component parent);
    super.new(name,parent);
  endfunction

  //------------------------------------------------------------------
  //function:-> build_phase
  //arguments :_> uvm_phase handle of uvm phase
  //description :-> in this phase all class objects are created
  //------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    for(int i=0; i<n; i++)begin

      m_seqr[i]=counter_sequencer::type_id::create($sformatf("m_seqr[%0d]",i),this);
    end
  endfunction

endclass : counter_virtual_sequencer








