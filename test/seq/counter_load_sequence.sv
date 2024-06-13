//-------------------------------------------------------------------------------
//class name:-> counter_load_sequence
//method:-> new
//description:-> this is a couunter load sequence class
//-------------------------------------------------------------------------------
class counter_load_sequence extends counter_sequence;
  //uvm factory registration
  `uvm_object_utils(counter_load_sequence)

  //declaration of handle
  counter_trans req;

  //------------------------------------------------------------------------
  //function :-> new
  //arguments:-> string name - name of the object
  //description:-> class constructor for counter down sequence
  //------------------------------------------------------------------------
  function new(string name = "counter_load_sequence");
    super.new(name);
  endfunction : new

  //------------------------------------------------------------------------
  //task:-> body
  //arguments:->
  //description:-> this task executes the sequence to generate transaction
  //-------------------------------------------------------------------------
  task body();

    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd55 ; req.load == 1'b1; req.enable == 1'b1;});
    end 

    repeat(10) begin
      `uvm_do_with(req,{req.enable == 1'b1;req.load == 1'b0; req.updown == 1'b1;});
    end 
    repeat(2) begin
      `uvm_do_with(req,{req.enable == 1'b0;req.load == 1'b0; req.updown == 1'b1;});   //To check Enable functionality
    end 
    
    repeat(1) begin
      `uvm_do_with(req,{req.data_in == 'd55 ; req.load == 1'b1; req.enable == 1'b1;});
    end 

    repeat(10) begin
      `uvm_do_with(req,{req.enable == 1'b1;req.load == 1'b0; req.updown == 1'b1;});
    end 

    repeat(2) begin
      `uvm_do_with(req,{req.enable == 1'b0;req.load == 1'b0; req.updown == 1'b1;});   //To check Enable functionality
    end 
   
    for(int i=0;i<256;i++) begin 
      repeat(1) begin
        `uvm_do_with(req,{req.data_in == i; req.load == 1'b1 ; req.enable == 1'b1;});   // To check Load functinality
      end 
      repeat(1) begin
        `uvm_do_with(req,{req.enable == 1'b1; req.load == 1'b0; req.updown == 1'b1;});
      end
    end

    repeat(1) begin
      `uvm_do_with(req,{req.data_in =='d0; req.load == 1'b1 ; req.enable == 1'b1; });
    end 

    repeat(10) begin
      `uvm_do_with(req,{req.enable == 1'b0; req.load == 1'b0; req.updown == 1'b1;});
    end

    repeat(2) begin
      `uvm_do_with(req,{req.enable == 1'b0;req.load == 1'b0; req.updown == 1'b1;});   //To check Enable functionality
    end 
   
    for(int i=0;i<256;i++) begin 
      repeat(1) begin
        `uvm_do_with(req,{req.data_in == i; req.load == 1'b1 ; req.enable == 1'b1;});   // To check Load functinality
      end 
      repeat(1) begin
        `uvm_do_with(req,{req.enable == 1'b1; req.load == 1'b0; req.updown == 1'b1;});
      end
    end
     
    repeat(1) begin
      `uvm_do_with(req,{req.data_in =='d10; req.load == 1'b1 ; req.enable == 1'b1;});
    end 

    repeat(10) begin
      `uvm_do_with(req,{req.enable == 1'b0; req.load == 1'b0; req.updown == 1'b1;});
    end

    repeat(5) begin
      `uvm_do_with(req,{req.enable == 1'b0;req.load == 1'b0; req.updown == 1'b1;});   //To check Enable functionality

    end 
 
    repeat(1) begin
      `uvm_do_with(req,{req.data_in =='d10; req.load == 1'b1 ; req.enable == 1'b1;});
    end 

    repeat(10) begin
      `uvm_do_with(req,{req.enable == 1'b0; req.load == 1'b0; req.updown == 1'b0;});
    end

    repeat(5) begin
      `uvm_do_with(req,{req.enable == 1'b0;req.load == 1'b0; req.updown == 1'b1;});   //To check Enable functionality

    end
    
    repeat(5) begin
        `uvm_do_with(req,{req.enable == 1'b0; req.load == 1'b1; req.updown == 1'b1;});
      end 
    
    for(int i=0;i<256;i++) begin 
      repeat(1) begin
        `uvm_do_with(req,{req.data_in == i; req.load == 1'b1 ; req.enable == 1'b1;});   // To check Load functinality
      end 
      repeat(1) begin
        `uvm_do_with(req,{req.enable == 1'b1; req.load == 1'b0; req.updown == 1'b1;});
      end
      
      repeat(1) begin
        `uvm_do_with(req,{req.enable == 1'b0; req.load == 1'b1; req.updown == 1'b1;});
      end


    end
    
  endtask : body

endclass : counter_load_sequence

