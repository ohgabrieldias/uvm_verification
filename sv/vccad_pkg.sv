//==============================================================================
// Project: VCC Arithmetic Decoder VIP
//==============================================================================
// Filename: vccad_pkg.sv
// Description: Package for VCC Arithmetic Decoder UVM Env.
//==============================================================================

package vccad_pkg;
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  // Include all UVM components
  `include "agents/vccad_agent.sv"
  `include "agents/vccad_driver.sv"
  `include "agents/vccad_monitor.sv"
  `include "agents/vccad_sequencer.sv"

  `include "env/vccad_env.sv"
  `include "env/vccad_config.sv"
  `include "env/vccad_coverage.sv"

  `include "sequences/vccad_base_seq.sv"
  `include "sequences/vccad_random_seq.sv"

  `include "tests/vccad_base_test.sv"
  `include "tests/vccad_regression_test.sv"

endpackage : vccad_pkg