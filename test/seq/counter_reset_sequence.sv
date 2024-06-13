//----------------------------------------------------------------------------------
//class name:-> counter_reset_sequence
//method:-> new
//description:-> this is counter reset sequence test
//----------------------------------------------------------------------------------
class counter_reset_sequence extends counter_sequence;

  //uvm factory registration
  `uvm_object_utils(counter_reset_sequence)

  //declaration of handle
  counter_trans req;

  //-------------------------------------------------------------------------------
  //function :-> new
  //arguments:-> string name  - name of the object
  //description :-> constructor for reset counter sequence
  //-------------------------------------------------------------------------------
  function new(string name = "counter_reset_sequence");
    super.new(name);
  endfunction : new

  //------------------------------------------------------------------------------
  //task :-> body
  //description:-> this task will generate transaction 
  //------------------------------------------------------------------------------
  task body();

    repeat(1)begin  
      `uvm_do_with(req,{req.data_in =='d30; req.load == 1'b1; req.enable ==1'b1;})
    end
    repeat(15) begin
      `uvm_do_with(req,{req.load ==1'b0; req.enable == 1'b1; req.updown == 1'b1;});
    end    
    repeat(1)begin  
      `uvm_do_with(req,{req.data_in == 'd20 ; req.load ==1'b1; req.enable == 1'b1;})
    end
    repeat(10) begin
      `uvm_do_with(req,{req.load ==1'b0; req.enable == 1'b1; req.updown == 1'b1;});
    end
    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd20 ; req.load ==1'b1; req.enable == 1'b1;});
    end
    repeat(15) begin
      `uvm_do_with(req,{req.load ==1'b0; req.enable == 1'b1; req.updown == 1'b1;});
    end
    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd20 ; req.load ==1'b1; req.enable == 1'b1;});
    end
    repeat(15) begin
      `uvm_do_with(req,{req.load ==1'b0; req.enable == 1'b1; req.updown == 1'b0;});
    end
    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd20 ; req.load ==1'b1; req.enable == 1'b1;});
    end
    repeat(15) begin
      `uvm_do_with(req,{req.load ==1'b0; req.enable == 1'b1; req.updown == 1'b0;});
    end 
    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd20 ; req.load ==1'b1; req.enable == 1'b1;});
    end   
    repeat(15) begin
      `uvm_do_with(req,{req.load ==1'b0; req.enable == 1'b1; req.updown == 1'b0;});
    end     
    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd20 ; req.load ==1'b1; req.enable == 1'b1;});
    end
    repeat(15) begin
      `uvm_do_with(req,{req.load ==1'b0; req.enable == 1'b1; req.updown == 1'b0;});
    end    

  endtask : body

endclass : counter_reset_sequence
