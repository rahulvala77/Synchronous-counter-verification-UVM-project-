//-------------------------------------------------------------------------------
//class name:-> counter_rollback_sequence
//method:-> new
//description:-> this is a counter rollback sequence class
//-------------------------------------------------------------------------------
class counter_rollback_sequence extends counter_sequence;
  //uvm factory registration
  `uvm_object_utils(counter_rollback_sequence)

  //declaration of handle
  counter_trans req;

  //------------------------------------------------------------------------
  //function :-> new
  //arguments:-> string name - name of the object
  //description:-> class constructor for counter rollback sequence
  //------------------------------------------------------------------------
  function new(string name = "counter_rollback_sequence");
    super.new(name);
  endfunction : new

  //------------------------------------------------------------------------
  //task:-> body
  //arguments:->
  //description:-> this task executes the sequence to generate transaction
  //-------------------------------------------------------------------------
  task body();

    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd3 ; req.load == 1'b1; req.enable == 1'b1;});
    end 

    repeat(100) begin
      `uvm_do_with(req,{req.enable == 1'b1;req.load == 1'b0; req.updown == 1'b0;});
    end

    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd10 ; req.load == 1'b1; req.enable == 1'b1;});
    end 

    repeat(300) begin
      `uvm_do_with(req,{req.enable == 1'b1;req.load == 1'b0; req.updown == 1'b0;});
    end

    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd3 ; req.load == 1'b1; req.enable == 1'b1;});
    end 

    repeat(300) begin
      `uvm_do_with(req,{req.enable == 1'b1;req.load == 1'b0; req.updown == 1'b0;});
    end


  endtask : body

endclass : counter_rollback_sequence

