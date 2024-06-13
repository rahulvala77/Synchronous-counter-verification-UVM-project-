//----------------------------------------------------------------
//file name:-> counter_top.sv
//module :-> counter_top
//description:-> This is TOP file in counter project
//----------------------------------------------------------------
module counter_top();
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import counter_pkg::*;

  parameter cycle =20;

  bit clk;

  counter_inf vif1(clk,reset);
  counter_inf vif2(clk,reset);

  dut_top DUV(.Clk(clk),
              .Reset(vif2.reset),
              .Enable_1(vif1.enable),
              .Load_1(vif1.load),
              .UpDown_1(vif1.updown),
              .In_Data_1(vif1.data_in),
              .Out_Data_1(vif1.data_out),
              .Enable_2(vif2.enable),
              .Load_2(vif2.load),
              .UpDown_2(vif2.updown),
              .In_Data_2(vif2.data_in),
              .Out_Data_2(vif2.data_out));               

  //Generate clock  
  initial 
    begin
      clk=1'b0;

    forever 
        #(cycle/2) clk =~clk;
    end
             
  initial 
    begin
      uvm_config_db#(virtual counter_inf)::set(null,"*","vif1",vif1);
      uvm_config_db#(virtual counter_inf)::set(null,"*","vif2",vif2);
      uvm_top.set_report_verbosity_level(UVM_LOW);
      run_test();
    end
    
endmodule
