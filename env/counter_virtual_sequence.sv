//------------------------------------------------------------------
//file name :-> counter_virtual_sequence.sv
//class:-> counter_virtual_sequence
//method:-> new
//description:-> this is counter virtual sequence class
//------------------------------------------------------------------
class counter_virtual_sequence extends uvm_sequence#(counter_trans);

  //uvm factory registration
  `uvm_object_utils(counter_virtual_sequence)

  //declaration of counter_sequencer
  counter_sequencer m_seqr1;
  counter_sequencer m_seqr2;

  `uvm_declare_p_sequencer(counter_virtual_sequencer)

  //declaration of counter_sequence handles
  counter_sequence m_seq1,m_seq2;

  //declaration of down sequence handle
  counter_down_sequence m_down_seq1,m_down_seq2;

  //declaration of up sequence handle
  counter_up_sequence m_up_seq1,m_up_seq2;

  //declaration of load sequence handle
  counter_load_sequence m_load_seq1, m_load_seq2 ;

  //declaration of rollover sequence handle
  counter_rollover_sequence m_rollover_seq1,m_rollover_seq2;

  //declaration of up_down sequence handle
  counter_up_down_sequence m_up_down_seq1,m_up_down_seq2;

  //declaration of rooback sequence handle
  counter_rollback_sequence m_rollback_seq1,m_rollback_seq2;

  //declaration of reset sequence handle
  counter_reset_sequence m_reset_seq1,m_reset_seq2;

  //declaration of one_counter one_up_second_down sequence handle
  counter_one_up_second_down_sequence1 m_one_up_sec_down_seq1;
  counter_one_up_second_down_sequence2 m_one_up_sec_down_seq2;

  //declaration of one_counter one_down_second_up sequence handle
  counter_one_down_second_up_sequence1 m_one_down_sec_up_seq1;
  counter_one_down_second_up_sequence2 m_one_down_sec_up_seq2;

  //-----------------------------------------------------------------
  //function :-> new
  //arguments:-> string name- name of object, uvm_component parent
  //description:-> 
  //----------------------------------------------------------------
  function new(string name = "counter_virtual_sequence");
    super.new(name);
  endfunction : new

  //---------------------------------------------------------------
  //task:-> this task is prebody
  //arguments :-> none
  //description:-> IN this task base sequence is created and virtual sequencer
  //contains sequencer pointed to actual base sequencer
  //---------------------------------------------------------------
  virtual task pre_body();

    m_seq1 = counter_sequence::type_id::create("m_seq1");
    m_seq2 = counter_sequence::type_id::create("m_seq2");

    m_seqr1 = p_sequencer.m_seqr[0];
    m_seqr2 = p_sequencer.m_seqr[1];

  endtask : pre_body

  //------------------------------------------------------------------
  //task:-> main body
  //arguments:-> none
  //description:->
  //-------------------------------------------------------------------
  virtual task body();

  endtask : body

endclass : counter_virtual_sequence
