//--------------------------------------------------------------------------------
//class :-> counter_up_virtual_seq
//method:-> new
////------------------------------------------------------------------------------
class counter_up_virtual_seq extends counter_virtual_sequence;
 
  //uvm factory registration
  `uvm_object_utils(counter_up_virtual_seq)

  //-----------------------------------------------------------------------------
  //funcntion:-> new
  //arguments:-> string name - name of the object
  //description:-> class constructor for counter up virtual seq
  //-----------------------------------------------------------------------------
  function new(string name = "counter_up_virtual_seq");
    super.new(name);
  endfunction : new

  //-----------------------------------------------------------------------------
  //task :_> body
  //description:-> this will generate transaaction from sequence execution
  //-----------------------------------------------------------------------------
  task body();
    begin
      $display("This is COUNTER UP TEST");
        fork
          begin
            //p_sequencer.m_env.start_reset(30);
          end
          begin
            `uvm_do_on(m_up_seq1,p_sequencer.m_seqr[0])
          end

          begin
            `uvm_do_on(m_up_seq2,p_sequencer.m_seqr[1])
          end

        join
    end
  endtask : body
endclass: counter_up_virtual_seq

//------------------------------------------------------------------------------
//file name:-> counter_up_test.sv
//class:-> counter_up_test
//------------------------------------------------------------------------------
class counter_up_test extends counter_base_test;

  //uvm factory registration
  `uvm_component_utils(counter_up_test)

  //handle of virtual sequence
  counter_up_virtual_seq up_seq;

  //-------------------------------------------------------------------
  //function:-> new
  //arguments:-> string name- name of the object uvm_component parent
  //descriptionn:-> counter up test constructor
  //-------------------------------------------------------------------
  function new (string name = "counter_up_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction : new

  //-------------------------------------------------------------------
  //function:-> build phase
  //arguments:-> uvm_phase - handle of uvm phase
  //descriptionn:-> In this phase all class objects are created
  //------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    up_seq=counter_up_virtual_seq::type_id::create("up_seq");
  endfunction : build_phase

  //-------------------------------------------------------------------
  //function:-> end of elaboration phase
  //arguments:-> uvm_phase - handle of uvm phase
  //descriptionn:-> This phase will print all TB structure
  //------------------------------------------------------------------
  function void end_of_elaboration();
    uvm_top.print_topology();
    uvm_report_info(get_full_name(),"End_of_elaboration",UVM_LOW);
  endfunction
   
  //-------------------------------------------------------------------
  //TASK:-> run_phase
  //arguments:-> 
  //descriptionn:-> This phase will start sequence on sequencer
  //------------------------------------------------------------------
   virtual task run_phase(uvm_phase phase);
     `uvm_info("up_test", $sformatf("This is a counter_up test in RUN PHASE"),UVM_HIGH)
     phase.raise_objection(this);
     up_seq.start(m_env.m_vseqr);
     phase.drop_objection(this);
   endtask : run_phase

endclass : counter_up_test

