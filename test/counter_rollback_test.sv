//-------------------------------------------------------------------------------
//class name:-> counter_rollback_virtual_seq
//method:-> new
//description :-> this is virtual seq of counter rollback test
//-------------------------------------------------------------------------------
class counter_rollback_virtual_seq extends counter_virtual_sequence;

  //uvm factory registration
  `uvm_object_utils(counter_rollback_virtual_seq)

  //-------------------------------------------------------------------------------
  //function:-> new
  //arguments:-> string name - name of the object
  //description:->  class constructor for counter rollback virtual seq
  //--------------------------------------------------------------------------------
  function new(string name = "counter_rollback_virtual_seq");
    super.new(name);
  endfunction : new

  //-----------------------------------------------------------------------------
  //task :-> body
  //arguments:-> 
  //description : -> this will executes to generate transaction
  //-----------------------------------------------------------------------------
  task body();
    begin
    fork
      `uvm_info("ROLLback_TEST", $sformatf("This is counter ROLLBACK Sequence starts here"),UVM_LOW)

       begin
          //p_sequencer.m_env.start_reset(30);
       end

       begin 
         `uvm_do_on(m_rollback_seq1, p_sequencer.m_seqr[0])
       end

       begin
         `uvm_do_on(m_rollback_seq2, p_sequencer.m_seqr[1])
       end

    join
    end
  endtask: body
endclass : counter_rollback_virtual_seq

//--------------------------------------------------------------------------
//file-name:-> counter_rollback_test.sv
//class name:-> counter_rollback_test
//methods :-> new
//description:-> this is rollback test in counter
//---------------------------------------------------------------------------
class counter_rollback_test extends counter_base_test;

  //uvm factory registration
  `uvm_component_utils(counter_rollback_test)

  //handle of virtual load seq
  counter_rollback_virtual_seq rollback_seq;

  //-----------------------------------------------------------------------------
  //function :-> new
  //arguments:-> string name- name of the object
  //description:-> constructor of the counter rollback test
  //-----------------------------------------------------------------------------
  function new(string name = "counter_rollback_test",uvm_component parent = null);
    super.new(name,parent);
  endfunction : new

  //------------------------------------------------------------------------------
  //function :-> build_phase
  //arguments:-> uvm_phase- handle of the uvm phase
  //description:-> in this phase all class objects are created
  //-----------------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("counter_rollback_test", $sformatf("this is counter_rollback_test in BUILD PHASE"),UVM_LOW)
    rollback_seq=counter_rollback_virtual_seq::type_id::create("m_rollback_seqs");
  endfunction : build_phase

  //--------------------------------------------------------------------------- 
  //function:-> end_of_elaboration
  //arguments:-> uvm_phase phase - handle of uvm_phase
  //description:-> this phase will print entire tb structure
  //---------------------------------------------------------------------------
  function void end_of_elaboration();
    uvm_top.print_topology();
    uvm_report_info(get_full_name(),"End_of_elaboration",UVM_LOW);
  endfunction

  //---------------------------------------------------------------------------
  //task:-> run_phase
  //arguments:-> 
  //description:-> execuion happens here
  //---------------------------------------------------------------------------
  virtual task run_phase(uvm_phase phase);
    `uvm_info("rollbacak_test",$sformatf("this is counter_rollback_test in RUN PHASE"), UVM_HIGH)
    phase.raise_objection(this);
    rollback_seq.start(m_env.m_vseqr);
    phase.drop_objection(this);
  endtask: run_phase
endclass: counter_rollback_test
