//----------------------------------------------------------------------
//file_name -> counter_sequence.sv
//class -> counter_sequence
//method -> new
//description -> base sequence file
//----------------------------------------------------------------------
typedef class counter_virtual_sequence;

class counter_sequence extends uvm_sequence #(counter_trans);
  
  //UVM factory registration
  `uvm_object_utils(counter_sequence)

  //---------------------------------------------------------------------
  //function -> new
  //arguments -> string name
  //description -> class constructor for updown counter sequence
  //-----------------------------------------------------------------------
  function new(string name = "counter_sequence");
    super.new(name);
  endfunction : new

  //-------------------------------------------------------------------
  //task ->  body
  //arguments -> NA
  //description -> NA
  //-------------------------------------------------------------------
  virtual task body();

  endtask : body
endclass : counter_sequence

class counter_test_virtual_seq extends counter_virtual_sequence;

  //uvm factory registration
  `uvm_object_utils(counter_test_virtual_seq)

  //----------------------------------------------------------------------
  //function -> new
  //arguments -> string name
  //description -> class constructor for updown counter sequence
  //---------------------------------------------------------------------
  function new(string name = "counter_test_virtual_seq");
    super.new(name);
  endfunction : new

  //----------------------------------------------------------------------
  //task -> body
  //arguments -> NA
  //description -> NA
  //------------------------------------------------------------------------
  virtual task body();

  endtask

endclass : counter_test_virtual_seq 
