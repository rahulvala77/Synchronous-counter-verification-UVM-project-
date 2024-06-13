//----------------------------------------------------------------------------------
//class name:-> counter_up_sequence
//method:-> new
//description:-> this is counter up_down sequence test
//----------------------------------------------------------------------------------
class counter_up_down_sequence extends counter_sequence;

  //uvm factory registration
  `uvm_object_utils(counter_up_down_sequence)

  //declaration of handle
  counter_trans req;

  //-------------------------------------------------------------------------------
  //function :-> new
  //arguments:-> string name  - name of the object
  //description :-> constructor for up_down counter sequence
  //-------------------------------------------------------------------------------
  function new(string name = "counter_up_down_sequence");
    super.new(name);
  endfunction : new

  //------------------------------------------------------------------------------
  //task :-> body
  //description:-> this task will generate transaction 
  //------------------------------------------------------------------------------
  task body();

    repeat(1)begin  
      `uvm_do_with(req,{req.data_in =='d1; req.load == 1'b1; req.enable ==1'b1;req.updown ==1'b1;})
    end

    repeat(260)begin  
      `uvm_do_with(req,{req.enable == 1'b1;req.load == 1'b0; req.updown ==1'b1;})
    end
    
    repeat(1)begin  
      `uvm_do_with(req,{req.data_in =='d5; req.load ==1'b1; req.enable == 1'b1;req.updown ==1'b0;})
    end

    repeat(260)begin  
      `uvm_do_with(req,{req.enable == 1'b1; req.load == 1'b0; req.updown ==1'b0;})
    end

  endtask : body

endclass : counter_up_down_sequence

