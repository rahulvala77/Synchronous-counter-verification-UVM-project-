//-------------------------------------------
//file method -> counter_trans.sv
//class       -> counter_trans
//methods     -> new
//description -> transaction class
//-------------------------------------------
class counter_trans extends uvm_sequence_item;
   
  rand logic enable;
  rand logic load;
  rand logic updown;
  rand logic [7:0] data_in;
  
  logic [7:0] data_out;
  
  // UVM factory registration
  `uvm_object_utils_begin(counter_trans)
    `uvm_field_int(enable,UVM_ALL_ON)
    `uvm_field_int(load,UVM_ALL_ON)
    `uvm_field_int(updown,UVM_ALL_ON)
    `uvm_field_int(data_in,UVM_ALL_ON)
    `uvm_field_int(data_out,UVM_ALL_ON)
  `uvm_object_utils_end

  //-----------------------------------------------
  //function  -> new
  //arguments -> string name
  //description -> constructor for up down counter
  //------------------------------------------------
  function new(string name = "counter_trans");
    super.new(name);
  endfunction : new

endclass : counter_trans
