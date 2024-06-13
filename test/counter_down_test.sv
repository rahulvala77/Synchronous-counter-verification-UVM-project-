//-------------------------------------------------------------------------------
//class name:-> counter_down_virtual_seq
//method:-> new
//description :-> this is virtual seq of counter down
//-------------------------------------------------------------------------------
class counter_down_virtual_seq extends counter_virtual_sequence;

  //uvm factory registration
  `uvm_object_utils(counter_down_virtual_seq)

  //-------------------------------------------------------------------------------
  //function:-> new
  //arguments:-> string name - name of the object
  //description:->  class constructor for counter down virtual seq
  //--------------------------------------------------------------------------------
  function new(string name = "counter_down_virtual_seq");
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
        `uvm_info("DOWN_TEST", $sformatf("This is counter DOWN Sequence starts here"),UVM_LOW)

        begin
          //p_sequencer.m_env.start_reset(30);
        end

        begin 
          `uvm_do_on(m_down_seq1, p_sequencer.m_seqr[0])
        end

        begin
          `uvm_do_on(m_down_seq2, p_sequencer.m_seqr[1])
        end

      join
    end
  endtask: body
endclass : counter_down_virtual_seq

//--------------------------------------------------------------------------
//file-name:-> counter_down_test.sv
//class name:-> counter_down_test
//methods :-> new
//description:-> this is down test in counter
//---------------------------------------------------------------------------
class counter_down_test extends counter_base_test;

  //uvm factory registration
  `uvm_component_utils(counter_down_test)

  //handle of virtual down seq
  counter_down_virtual_seq down_seq;

  //-----------------------------------------------------------------------------
  //function :-> new:browse confirm wa
  //
  //arguments:-> string name- name of the object
  //description:-> constructor of the counter down test
  //-----------------------------------------------------------------------------
  function new(string name = "counter_down_test",uvm_component parent = null);
    super.new(name,parent);
  endfunction : new

  //------------------------------------------------------------------------------
  //function :-> build_phase
  //arguments:-> uvm_phase- handle of the uvm phase
  //description:-> in this phase all class objects are created
  //-----------------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("counter_down_test", $sformatf("this is counter_down_test in BUILD PHASE"),UVM_LOW)
    down_seq=counter_down_virtual_seq::type_id::create("down_seq");
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
    `uvm_info("down_test",$sformatf("this is counter_down_test in RUN PHASE"), UVM_HIGH)
    phase.raise_objection(this);
    down_seq.start(m_env.m_vseqr);
    phase.drop_objection(this);

  endtask: run_phase
endclass: counter_down_test
