//--------------------------------------------------------------------------
//file name:-> counter_pkg.sv
//package :-> counter_pkg
//description:-> this package file contains all files inclusion
//--------------------------------------------------------------------------
package counter_pkg;

  import uvm_pkg::*;
  
  `include "uvm_macros.svh"

  `include "counter_parameters.sv"
  `include "counter_config.sv"
  `include "counter_trans.sv"
  `include "counter_ref_trans.sv"
  `include "counter_sequence.sv"
  `include "counter_sequencer.sv"
  `include "counter_driver.sv"
  `include "counter_monitor.sv"
  `include "counter_agent.sv"
  `include "counter_predictor.sv"
  `include "counter_coverage.sv"
  `include "counter_scoreboard.sv"
  `include "counter_env.sv"

  //Test cases
  `include "base_report_server.sv"
  `include "counter_base_test.sv"
  `include "counter_up_test.sv"
  `include "counter_down_test.sv"
  `include "counter_reset_test.sv"
  `include "counter_rollover_test.sv"
  `include "counter_rollback_test.sv"
  `include "counter_up_down_test.sv"
  `include "counter_load_test.sv"
  `include "counter_one_up_second_down_test.sv"
  `include "counter_one_down_second_up_test.sv"
  `include "counter_up_sequence.sv"
  `include "counter_down_sequence.sv"
  `include "counter_reset_sequence.sv"
  `include "counter_rollback_sequence.sv"
  `include "counter_rollover_sequence.sv"
  `include "counter_up_down_sequence.sv"
  `include "counter_load_sequence.sv"
  `include "counter_one_up_second_down_sequence1.sv"
  `include "counter_one_up_second_down_sequence2.sv"
  `include "counter_one_down_second_up_sequence1.sv"
  `include "counter_one_down_second_up_sequence2.sv"

  `include "counter_virtual_sequence.sv"
  `include "counter_virtual_sequencer.sv"
  
endpackage : counter_pkg
