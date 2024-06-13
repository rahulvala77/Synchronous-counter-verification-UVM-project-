//-------------------------------------------------------------------------------
//class name:-> counter_down_sequence
//method:-> new
//description:-> this is a couunter down sequence class
//-------------------------------------------------------------------------------
class counter_down_sequence extends counter_sequence;
  //uvm factory registration
  `uvm_object_utils(counter_down_sequence)

  //declaration of handle
  counter_trans req;

  //------------------------------------------------------------------------
  //function :-> new
  //arguments:-> string name - name of the object
  //description:-> class constructor for counter down sequence
  //------------------------------------------------------------------------
  function new(string name = "counter_down_sequence");
    super.new(name);
  endfunction : new

  //------------------------------------------------------------------------
  //task:-> body
  //arguments:->
  //description:-> this task executes the sequence to generate transaction
  //-------------------------------------------------------------------------
  task body();
    
    repeat(260) begin
      `uvm_do_with(req,{req.enable == 1'b1;req.load == 1'b0;  req.updown == 1'b0;});
    end 

  endtask : body
endclass : counter_down_sequence
