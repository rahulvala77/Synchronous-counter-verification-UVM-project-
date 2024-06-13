//----------------------------------------------------------------------------------------
//file name :-> counter_config.sv
//class :-> couunter_config
//description :-> in this class agents can be set AVTIVE or PASSIVE.
//----------------------------------------------------------------------------------------
class counter_config extends uvm_component;

  //uvm factory registration
  `uvm_component_utils(counter_config)

  //---------------------------------------------------------------------------------------
  //function :-> new
  //arguments:-> string name- name of object, uvm component parent
  //description :-> constructor for counter config
  //---------------------------------------------------------------------------------------
  function new(string name = "counter_config", uvm_component parent);
	  super.new(name, parent);
  endfunction

  uvm_active_passive_enum is_active = UVM_ACTIVE;

endclass : counter_config
