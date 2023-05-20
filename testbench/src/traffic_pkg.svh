`timescale 1ns/1ns
import uvm_pkg::*;

package traffic_pkg;
  `include "uvm_macros.svh"

  `include "apb_seq_item.svh"
  `include "apb_reset_sequence.svh"
  `include "apb_driver.svh"
  `include "apb_monitor.svh"
  `include "apb_agent.svh"

  `include "traffic_reg_ctl.svh"
  `include "traffic_reg_state.svh"
  `include "traffic_reg_timer.svh"
  
  `include "ral_reg_block_cfg.svh"
  `include "ral_reg_block_sys.svh"
  `include "ral_reg2apb_adapter.svh"

  `include "ral_reg_env.svh"
  `include "apb_env.svh"

  `include "traffic_base_test.svh"
  `include "traffic_reg_rw_test.svh"
endpackage
