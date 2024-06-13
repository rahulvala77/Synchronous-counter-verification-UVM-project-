//--------------------------------------------------------------------------------
//class :-> counter_reset_virtual_seq
//method:-> new
////------------------------------------------------------------------------------
class counter_reset_virtual_seq extends counter_virtual_sequence;
 
  //uvm factory registration
  `uvm_object_utils(counter_reset_virtual_seq)

  //-----------------------------------------------------------------------------
  //funcntion:-> new
  //arguments:-> string name - name of the object
  //description:-> class constructor for counter reset virtual seq
  //-----------------------------------------------------------------------------
  function new(string name = "counter_reset_virtual_seq");
    super.new(name);
  endfunction : new

  //-----------------------------------------------------------------------------
  //task :_> body
  //description:-> this will generate transaaction from sequence execution
  //-----------------------------------------------------------------------------
  task body();
    begin
      $display("This is COUNTER RESET TEST");
        fork
          begin
            //#1;
            //p_sequencer.m_env.start_reset(30);           //reset at initialization
          end
          begin
            `uvm_do_on(m_reset_seq1,p_sequencer.m_seqr[0])
          end
          begin
            `uvm_do_on(m_reset_seq2,p_sequencer.m_seqr[1])
          end
          
          begin
           #120 p_sequencer.m_env.start_reset(19);  // to check reset for less than 20ns
          end

          begin 
            #205 p_sequencer.m_env.start_reset(20);  // to check reset for equal to 20ns
          end
          
          begin
            #410 p_sequencer.m_env.start_reset(21);  // to check reset for more than 20ns
          end

          begin 
           #615 p_sequencer.m_env.start_reset(8);  // to check reset for less than 10ns
          end

          begin
            #805 p_sequencer.m_env.start_reset(20);  // to apply reset at middle of negative clock pulse
          end

          begin 
            #1010 p_sequencer.m_env.start_reset(12); //to apply reset at the start of possitive clock pulse
          end
          
          begin
            #1215 p_sequencer.m_env.start_reset(22); // to apply reset at the middle of the positive pulse
          end

          begin 
          #1400 p_sequencer.m_env.start_reset(10); // to apply reset at the end of the positive pulse
          end         

        join
    end
  endtask : body
endclass: counter_reset_virtual_seq

//------------------------------------------------------------------------------
//file name:-> counter_reset_test.sv
//class:-> counter_reset_test
//------------------------------------------------------------------------------
class counter_reset_test extends counter_base_test;

  //uvm factory registration
  `uvm_component_utils(counter_reset_test)

  //handle of virtual sequence
  counter_reset_virtual_seq reset_seq;

  //-------------------------------------------------------------------
  //function:-> new
  //arguments:-> string name- name of the object uvm_component parent
  //descriptionn:-> counter reset test constructor
  //-------------------------------------------------------------------
  function new (string name = "counter_reset_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction : new

  //-------------------------------------------------------------------
  //function:-> build phase
  //arguments:-> uvm_phase - handle of uvm phase
  //descriptionn:-> In this phase all class objects are created
  //------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reset_seq=counter_reset_virtual_seq::type_id::create("reset_seq");
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
     `uvm_info("reset_test", $sformatf("This is a counter_reset test in RUN PHASE"),UVM_LOW)
     phase.raise_objection(this);
       reset_seq.start(m_env.m_vseqr);
     phase.drop_objection(this);
   endtask : run_phase

endclass : counter_reset_test
