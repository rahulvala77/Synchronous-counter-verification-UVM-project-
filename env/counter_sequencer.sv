//--------------------------------------------------------------------------------------
//file name -> counter_sequencer.sv
//class -> counter_sequencer
//method -> new
//description -> this is a base sequencer class
//-------------------------------------------------------------------------------------
class counter_sequencer extends uvm_sequencer#(counter_trans);

  //UVM factry registrations
  `uvm_component_utils(counter_sequencer)

  //-----------------------------------------------------------------------------------
  //fucntion -> new
  //arguments -> string name
  // description -> constructor for counter_sequencer
  //-------------------------------------------------------------------------------
  function new(string name = "counter_sequencer",uvm_component parent = null);
    super.new(name,parent);
  endfunction : new

endclass : counter_sequencer
