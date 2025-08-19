//==============================================================================
// Project: VCC Arithmetic Decoder VIP
//==============================================================================
// Filename: vccad_top.sv
// Description: Top-level module for VCC Arithmetic Decoder UVM testbench
//==============================================================================


`include "vccad_if.sv"

module vccad_top;
  
  // Package imports
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import vccad_pkg::*;

  // Clock and reset signals
  reg clk;
  reg reset;

  // Interface instance
  vccad_if dec_if(.clk(clk), .reset(reset));

  //----------------------------------------------------------------------------
  // Clock generation
  //----------------------------------------------------------------------------
  initial begin
    clk = 1'b0;
    forever #5ns clk = ~clk;  // 100MHz clock
  end

  //----------------------------------------------------------------------------
  // Reset generation
  //----------------------------------------------------------------------------
  initial begin
    reset = 1'b1;
    #100ns reset = 1'b0;
  end

  //----------------------------------------------------------------------------
  // DUT instantiation (from the RTL submodule)
  //----------------------------------------------------------------------------
  Decoder #(.BIN_WIDTH(4)) dut (
    .clk                (clk),
    .reset              (reset),
    .bypass             (dec_if.bypass),
    .pState_in          (dec_if.pState_in),
    .n_bin              (dec_if.n_bin),
    .m_value_binRE_in   (dec_if.m_value_binRE_in),
    .m_value_binEP0_in  (dec_if.m_value_binEP0_in),
    .m_value_binEP1_in  (dec_if.m_value_binEP1_in),
    .m_value_binEP2_in  (dec_if.m_value_binEP2_in),
    .m_value_binEP3_in  (dec_if.m_value_binEP3_in),
    .bin                (dec_if.bin),
    .m_value_binRE_out  (dec_if.m_value_binRE_out),
    .m_value_binEP0_out (dec_if.m_value_binEP0_out),
    .m_value_binEP1_out (dec_if.m_value_binEP1_out),
    .m_value_binEP2_out (dec_if.m_value_binEP2_out),
    .m_value_binEP3_out (dec_if.m_value_binEP3_out),
    .numBits            (dec_if.numBits),
    .mps_renorm         (dec_if.mps_renorm),
    .lps                (dec_if.lps)
  );

  //----------------------------------------------------------------------------
  // UVM initialization and configuration
  //----------------------------------------------------------------------------
  initial begin
    // Set the virtual interface in the configuration database
    uvm_config_db#(virtual vccad_if)::set(
      null, 
      "uvm_test_top.env", 
      "decoder_vif", 
      dec_if
    );

    // Set decoder parameters
    uvm_config_db#(int)::set(null, "uvm_test_top.env", "bin_width", 4);
    
    // Start the test
    run_test("vccad_base_test");
  end

  //----------------------------------------------------------------------------
  // Waveform dumping
  //----------------------------------------------------------------------------
  initial begin
    if ($test$plusargs("wave")) begin
      $dumpfile("vcc_decoder_waves.vcd");
      $dumpvars(0, vccad_top);
      $dumpvars(0, dut);
    end
  end

  //----------------------------------------------------------------------------
  // Simulation control
  //----------------------------------------------------------------------------
  initial begin
    #1000000ns; // Simulation timeout
    $display("Simulation timeout reached");
    $finish;
  end

endmodule : vccad_top