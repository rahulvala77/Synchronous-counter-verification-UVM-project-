//----------------------------------------------------------------------------------------------
//file-name -> base_report_server.sv
//class     -> base_report_server
//methods   -> new
//description -> this component is uder to report if any warning, info, error and fatal.
//----------------------------------------------------------------------------------------------
class base_report_server extends uvm_report_server;

  int uvm_warn_cnt;
  int uvm_info_cnt;
  int uvm_error_cnt;
  int uvm_fatal_cnt;
  
  //uvm factory registration
  `uvm_object_utils(base_report_server)
  
  //-------------------------------------------------------------------
  //function  -> new
  //arguments -> string name
  //description -> constructor for base_report_server
  //------------------------------------------------------------------
  function new(string name = "base_report_server");
    super.new();
  endfunction

  virtual function void report_summarize(UVM_FILE file = 0);
    uvm_warn_cnt  = get_severity_count(UVM_WARNING);
    uvm_info_cnt  = get_severity_count(UVM_INFO);
    uvm_error_cnt = get_severity_count(UVM_ERROR);
    uvm_fatal_cnt = get_severity_count(UVM_FATAL);

    if((uvm_error_cnt != 0) || (uvm_fatal_cnt != 0) || (uvm_warn_cnt != 0)) begin
      $display("***************---------FAIL---------------**********************");
      end 
    else begin
      $display("***************---------PASS---------------**********************"); 
      end

  endfunction
endclass : base_report_server
