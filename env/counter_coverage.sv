//-------------------------------------------------------------------------------------------------------------
//file name:-> counter_coverage.sv
//class :-> up_down_coverage
//method:-> new
//description:-> this class is coverage classs in which covergroups and coverpoints are written
//-------------------------------------------------------------------------------------------------------------
class up_down_coverage extends uvm_component;
  
  //uvm factory registration
  `uvm_component_utils(up_down_coverage)

  //-------------------------------------------------------------------------------------------------------------
  //covergroup :-> m_up_coverage
  //description:-> this covergroup checks all the data values of out_data
  //-------------------------------------------------------------------------------------------------------------
  covergroup m_up_coverage with function sample(bit[7:0] data_out,reset,load,enable,updown,bit[7:0] prev_data_out);
     
    UP_DUT_BY_1       : coverpoint data_out iff(!reset && (load == 0) && (enable == 1) && (updown ==1) && ((data_out - prev_data_out) == 1)) {bins DUT[] = {[1:255]};}
 
  endgroup      
  //-----------------------------------------------------------------------------------------------------------
  //covergroup :-> m_down_coverage
  //description:-> this covergroup checks all the data values of out_data
  //-----------------------------------------------------------------------------------------------------------
  covergroup m_down_coverage with function sample(bit[7:0] data_out,reset,load,enable,updown,bit[7:0] prev_data_out);

    DOWN_DUT_BY_1     : coverpoint data_out iff(!reset && (load == 0) && (enable == 1) && (updown ==0) && ((prev_data_out - data_out) == 1)) {bins DUT[] = {[0:254]};}

  endgroup
  //---------------------------------------------------------------------------------------------------------
  //covergroup :-> m_reset_coverage
  //description:-> this covergroup checks all the data values of out_datain reset state
  //----------------------------------------------------------------------------------------------------------
  covergroup m_reset_coverage with function sample(bit[7:0] data_out,reset,reset_pulse_width);

    RESET_LOW_WIDTH   : coverpoint data_out iff( reset && (reset_pulse_width < 20)) {bins SAME = {[1:$]};}
    OUT_HIGH_WIDTH    : coverpoint data_out iff( reset && (!data_out) && (reset_pulse_width >= 20)) {bins OUT_DATA_WHEN_RESET = {0}; }
    
    cp_device_rst_width : coverpoint reset_pulse_width {
      option.comment = "This coverpoint Cover pulse width of Device Reset."; 
      bins cb_reset_less_min_minus_one    = {[1:(RESET_MIN -1)]} ;
      bins cb_reset_min                   = {RESET_MIN} ;
      bins cb_reset_max                   = {RESET_MAX} ;
      bins cb_reset_greater_max_plus_one  = {[(RESET_MAX +1):$]} ;
         }    
  endgroup
  //-----------------------------------------------------------------------------------------------------------
  //covergroup :-> m_rollback_coverage
  //description:-> this covergroup checks all the data values of out_data to rollback 0 to 0xFF (Decrement)
  //-------------------------------------------------------------------------------------------------------------
  covergroup m_rollback_coverage with function sample(bit[7:0] data_out,reset,load,enable,updown,prev_data_out);

    ROLLBACK_OUT_DATA : coverpoint data_out iff(!reset && (load == 0) && (enable == 1) && (updown ==0) ) {bins TWO2ONE  =  (2=>1);
                                                                                                          bins ONE2ZERO = (1=>0);                                                                                                                                             bins WRAPAROUND = (8'h0=>8'hff);
                                                                                                          bins MAX2SECONDLAST = (8'hff=>8'hfe); }
    
  endgroup
  //---------------------------------------------------------------------------------------------------------
  //covergroup :-> m_rollover_coverage
  //description:-> this covergroup checks all the data values of out_data to rollback 0xFF to 0(Increment)
  //----------------------------------------------------------------------------------------------------------
  covergroup m_rollover_coverage with function sample(bit[7:0] data_out,reset,load,enable,updown,prev_data_out);

    ROLLOVER_OUT_DATA : coverpoint data_out iff(!reset && (load == 0) && (enable == 1) && (updown == 1)) {bins SECONDLAST2MAXIMUM = ('hfe => 'hff); 
                                                                                                          bins WRAPAROUND = ('hff => 'h0);
                                                                                                          bins ZERO2ONE = (0 => 1);
                                                                                                          bins ONE2TWO  = (1 => 2);  }                                                                                                                                        
  endgroup
  //------------------------------------------------------------------------------------------------------------
  //covergroup :-> m_up_down_coverage
  //description:-> this covergroup checks all the data values of out_data for up and down counting 
  //------------------------------------------------------------------------------------------------------------
  covergroup m_up_down_coverage with function sample(bit[7:0] data_out,reset,load,enable,updown,prev_data_out);

    LOAD              : coverpoint load {bins ZERO = {0}; bins ONE = {1}; bins ZEROTOONE = (0=>1); bins ONETOZERO = (1=>0);}
    UPDOWN            : coverpoint updown {bins ZERO = {0}; bins ONE = {1}; bins ZEROTOONE = (0=>1); bins ONETOZERO = (1=>0);}     
    UP_DUT_BY_1       : coverpoint data_out iff(!reset && (enable == 1) && (updown ==1) && ((data_out - prev_data_out) == 1)) {bins DUT[] = {[1:255]};}
    DOWN_DUT_BY_1     : coverpoint data_out iff(!reset && (enable == 1) && (updown ==0) && ((prev_data_out - data_out) == 1)) {bins DUT[] = {[0:254]};}

  endgroup
  //----------------------------------------------------------------------------------------------------------------
  //covergroup :-> m_load_coverage
  //description:-> this covergroup checks load pin functionality to check output data load correctly or not
  //----------------------------------------------------------------------------------------------------------------
  covergroup m_load_coverage with function sample(bit[7:0] data_in, bit[7:0] data_out,reset,load,enable,updown,bit[7:0] prev_data_out);

    IN_DATA           : coverpoint data_in iff(!reset && (load == 1) && (enable ==1)) {bins in_data[] = {[8'h0 : 8'hff]}; }
    LOAD_OUT_DATA     : coverpoint data_out iff(!reset && (enable ==1) && (load ==0)) {bins out_data[] = {[8'h0 : 8'hff]}; }
    OUT_DATA_WHEN_LOAD: coverpoint data_out iff(!reset && load && enable)  {bins equal_data = {data_in};}
    OUT_DATA_WHEN_EN  : coverpoint data_out iff(!reset &&  (enable == 0) && (load == 0)) {bins NOT_EN = {prev_data_out};}

  endgroup
  //------------------------------------------------------------------------------------------------------------
  //covergroup :-> m_one_up_second_down_coverage
  //description:-> this covergroup checks all the data values of out_data for one up and second down counting 
  //------------------------------------------------------------------------------------------------------------
  covergroup m_one_up_second_down_coverage with function sample(bit[7:0] data_out,reset,load,enable,updown,prev_data_out);

    LOAD              : coverpoint load {bins ZERO = {0}; bins ONE = {1}; bins ZEROTOONE = (0=>1); bins ONETOZERO = (1=>0);}
    ENABLE            : coverpoint enable {bins ZERO = {0}; bins ONE = {1}; bins ZEROTOONE = (0=>1); }
    UPDOWN            : coverpoint updown {bins ZERO = {0}; bins ONE = {1}; bins ZEROTOONE = (0=>1); bins ONETOZERO = (1=>0);}
    UP_DUT_BY_1       : coverpoint data_out iff(!reset && (enable == 1) && (updown ==1) && ((data_out - prev_data_out) == 1)) {bins DUT[] = {[1:255]};}
    DOWN_DUT_BY_1     : coverpoint data_out iff(!reset && (enable == 1) && (updown ==0) && ((prev_data_out - data_out) == 1)) {bins DUT[] = {[0:254]};}
  endgroup
  //------------------------------------------------------------------------------------------------------------
  //covergroup :-> m_one_down_second_up_coverage
  //description:-> this covergroup checks all the data values of out_data for one down and second up counting 
  //------------------------------------------------------------------------------------------------------------
  covergroup m_one_down_second_up_coverage with function sample(bit[7:0] data_out,reset,load,enable,updown,prev_data_out);

    LOAD              : coverpoint load {bins ZERO = {0}; bins ONE = {1}; bins ZEROTOONE = (0=>1); bins ONETOZERO = (1=>0);}
    ENABLE            : coverpoint enable {bins ZERO = {0}; bins ONE = {1}; bins ZEROTOONE = (0=>1); }
    UPDOWN            : coverpoint updown {bins ZERO = {0}; bins ONE = {1}; bins ZEROTOONE = (0=>1); bins ONETOZERO = (1=>0);}
    UP_DUT_BY_1       : coverpoint data_out iff(!reset && (enable == 1) && (updown ==1) && ((data_out - prev_data_out) == 1)) {bins DUT[] = {[1:255]};}
    DOWN_DUT_BY_1     : coverpoint data_out iff(!reset && (enable == 1) && (updown ==0) && ((prev_data_out - data_out) == 1)) {bins DUT[] = {[0:254]};}
  endgroup
  //-------------------------------------------------------------------------------------------------------------
  //fucntion:-> new
  //arguments:-> string name - name of the object , uvm component parent
  //description:-> construction for creating this class object
  //--------------------------------------------------------------------------------------------------------------
  function new(string name = "counter coverage", uvm_component parent = null);
    super.new(name,parent);

    m_up_coverage = new();
    m_down_coverage = new();
    m_reset_coverage = new();
    m_rollover_coverage = new();
    m_rollback_coverage = new();
    m_up_down_coverage = new();
    m_load_coverage = new();
    m_one_up_second_down_coverage = new();
    m_one_down_second_up_coverage = new();

  endfunction : new

endclass : up_down_coverage

