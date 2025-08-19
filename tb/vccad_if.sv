//==============================================================================
// Project: VCC Arithmetic Decoder VIP
//==============================================================================
// Filename: vccad_if.sv
// Description: Interface for VCC Arithmetic Decoder
//==============================================================================

interface vccad_if(input logic clk, input logic reset);
  
  // Parameters
  parameter BIN_WIDTH = 4;

  // Input signals
  logic        bypass;
  logic [7:0]  pState_in;
  logic [1:0]  n_bin;
  logic [15:0] m_value_binRE_in;
  logic [16:0] m_value_binEP0_in;
  logic [16:0] m_value_binEP1_in;
  logic [16:0] m_value_binEP2_in;
  logic [16:0] m_value_binEP3_in;

  // Output signals
  logic [BIN_WIDTH-1:0] bin;
  logic [15:0] m_value_binRE_out;
  logic [16:0] m_value_binEP0_out;
  logic [16:0] m_value_binEP1_out;
  logic [16:0] m_value_binEP2_out;
  logic [16:0] m_value_binEP3_out;
  logic [2:0]  numBits;
  logic        mps_renorm;
  logic        lps;


endinterface : vccad_if
