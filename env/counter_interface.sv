//---------------------------------------------------------------------------
//file name -> counter_interface.sv
//class     -> counter_interface
//method    -> new
//description -> used to connect env with DUT
//---------------------------------------------------------------------------
interface counter_inf(input bit clk,reset);

  logic enable;
  logic updown;
  logic load;
  logic [7:0] data_in;
  logic [7:0] data_out;

  //Clocking block for driver
  clocking drv_cb@(posedge clk);
    default input#0 output#1;
    output enable;
    output updown;
    output load;
    output data_in;
  endclocking  

  //clocking block for monitor
  clocking mon_cb@(posedge clk);
    default input#0 output#1;
    input enable;
    input updown;
    input load;
    input data_in;
    input data_out;
  endclocking

  //modport declaration
  modport DRV_MP(clocking drv_cb);
  modport MON_MP(clocking mon_cb);

endinterface : counter_inf
