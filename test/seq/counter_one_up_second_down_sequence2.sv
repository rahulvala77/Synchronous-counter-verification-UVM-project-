//-------------------------------------------------------------------------------
//class name:-> counter_one_up_second_down_sequence2
//method:-> new
//description:-> this is a couunter down sequence2 class
//-------------------------------------------------------------------------------
class counter_one_up_second_down_sequence2 extends counter_sequence;
  
  //uvm factory registration
  `uvm_object_utils(counter_one_up_second_down_sequence2)

  //declaration of handle
  counter_trans req;

  //------------------------------------------------------------------------
  //function :-> new
  //arguments:-> string name - name of the object
  //description:-> class constructor for counter down sequence
  //------------------------------------------------------------------------
  function new(string name = "counter_one_up_second_down_sequence2");
    super.new(name);
  endfunction : new

  //------------------------------------------------------------------------
  //task:-> body
  //arguments:->
  //description:-> this task executes the sequence to generate up sequence
  //-------------------------------------------------------------------------
  task body();

     repeat(1)begin  
      `uvm_do_with(req,{req.data_in =='d100; req.load == 1'b1; req.enable ==1'b1;})
    end

    repeat(10)begin  
      `uvm_do_with(req,{req.load == 1'b0; req.enable == 1'b1; req.updown == 1'b0;})
    end

    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd220 ; req.load == 1'b1; req.enable == 1'b1;});
    end 

    repeat(270) begin
      `uvm_do_with(req,{req.enable == 1'b1;req.load == 1'b0; req.updown == 1'b0;});
    end 
  endtask : body

endclass : counter_one_up_second_down_sequence2

