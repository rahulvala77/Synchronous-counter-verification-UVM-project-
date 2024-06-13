//------------------------------------------------------------------------------------
//file-name:-> counter_base_test.sv
//class :-> counter_base_test
//description:-> this is main test or base test for counter project
//------------------------------------------------------------------------------------
import counter_pkg::*;

class counter_base_test extends uvm_test;
 
  `uvm_component_utils(counter_base_test)
  
  // declaration of envirnment handle
  counter_env m_env;

  //declaration of virtual seqs
  counter_virtual_sequence v_seqs;
  
  //declaration of base report server instance
  protected base_report_server report;

  //----------------------------------------------------------------------------------
  //function:-> new
  //arguments:-> string name - name of object uvm_component parent
  //description:-> construction of counter_base_test
  //----------------------------------------------------------------------------------
  function new (string name = "counter_base_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction : new

  //---------------------------------------------------------------------------------
  //function:-> build_phase
  //arguments:-> uvm_phase phase - handle of uvm_phase
  //description:-> this is a phase in which all class objects are created
  //---------------------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    report= new();
    m_env= counter_env::type_id::create("m_env",this);
    v_seqs=counter_virtual_sequence::type_id::create("v_seqs");
    uvm_report_server::set_server(report);
  endfunction : build_phase

  //---------------------------------------------------------------------------------
  //function:-> end of elaboration 
  //arguments:-> uvm_phase phase - handle of uvm_phase
  //description:-> this phase wil print entire TB structure
  //---------------------------------------------------------------------------------
  function void end_of_elaboration();
    uvm_top.print_topology();
    uvm_report_info(get_full_name(),"End_of_elaboration",UVM_LOW);
  endfunction
  
  //---------------------------------------------------------------------------------
  //function:-> run_phase
  //arguments:-> uvm_phase phase - handle of uvm_phase
  //description:-> this phase will run the base test
  //---------------------------------------------------------------------------------
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    v_seqs.start(m_env.m_vseqr);

  endtask : run_phase
endclass : counter_base_test 
  
