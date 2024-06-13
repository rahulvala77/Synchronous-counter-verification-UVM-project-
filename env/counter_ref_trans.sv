//------------------------------------------------------------
//file name -> counter_ref_trans.sv
//claass    -> counter_ref_trans
//methods   -> new
//description -> this class is transactio class for predictor
//-----------------------------------------------------------
class counter_ref_trans extends uvm_sequence_item;

  //declaration of variables
  static bit temp_reset;
  bit temp_enable;
  bit temp_updown;
  bit temp_load;
  bit [7:0] temp_data_in;
  bit [7:0] temp_data_out;
  int rst_width;
 
  //uvm factory registration
  `uvm_object_utils_begin(counter_ref_trans)
    `uvm_field_int(temp_reset,UVM_ALL_ON)
    `uvm_field_int(temp_enable,UVM_ALL_ON)
    `uvm_field_int(temp_updown,UVM_ALL_ON)
    `uvm_field_int(temp_load,UVM_ALL_ON)
    `uvm_field_int(temp_data_in,UVM_ALL_ON)
    `uvm_field_int(temp_data_out,UVM_ALL_ON)
    `uvm_field_int(rst_width,UVM_ALL_ON)
  `uvm_object_utils_end

  //-----------------------------------------------
  //function:-> new
  //arguments:-> string name  : name of object
  //description :-> class construction
  //-----------------------------------------------
  function new(string name = "counter_ref_trans");
    super.new(name);
  endfunction : new

endclass : counter_ref_trans  

