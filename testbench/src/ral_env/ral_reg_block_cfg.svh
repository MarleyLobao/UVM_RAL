class ral_reg_block_cfg extends uvm_reg_block;
  rand traffic_reg_ctl   ctrl;     // RW
  rand traffic_reg_timer timer[2]; // RW
  traffic_reg_state      state;    // RO

  `uvm_object_utils(ral_reg_block_cfg)

  function new(string name = "ral_reg_block_cfg");
    super.new(name, build_coverage(UVM_NO_COVERAGE));
  endfunction

  virtual function void build();
    this.default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN, 0);

    this.ctrl = traffic_reg_ctl::type_id::create("ctrl", , get_full_name());
    this.ctrl.configure(this, null, "");
    this.ctrl.build();

    `ifdef BACKDOOR_MODE
      // HDL path to this instance is "traffic_top.my_traffic.ctl_reg"
      ctrl.add_hdl_path_slice("ctl_reg", 0, ctrl.get_n_bits());
    `endif
    this.default_map.add_reg(this.ctrl, `UVM_REG_ADDR_WIDTH'h0, "RW", 0);
     
    this.timer[0] = traffic_reg_timer::type_id::create("timer[0]", , get_full_name());
    this.timer[0].configure(this, null, "");
    this.timer[0].build();

    `ifdef BACKDOOR_MODE
      // HDL path to this instance is "traffic_top.my_traffic.timer_0"
      timer[0].add_hdl_path_slice("timer_0", 0, timer[0].get_n_bits());
    `endif
    this.default_map.add_reg(this.timer[0], `UVM_REG_ADDR_WIDTH'h4, "RW", 0);

    this.timer[1] = traffic_reg_timer::type_id::create("timer[1]", , get_full_name());
    this.timer[1].configure(this, null, "");
    this.timer[1].build();

    `ifdef BACKDOOR_MODE
      // HDL path to this instance is "traffic_top.my_traffic.timer_1"
      timer[1].add_hdl_path_slice("timer_1", 0, timer[1].get_n_bits());
    `endif
    this.default_map.add_reg(this.timer[1], `UVM_REG_ADDR_WIDTH'h8, "RW", 0);

    this.state = traffic_reg_state::type_id::create("state", , get_full_name());
    this.state.configure(this, null, "");
    this.state.build();

    `ifdef BACKDOOR_MODE
      // HDL path from DUT to the status register will now be 
      // "traffic_top.my_traffic.stat_reg" after the previous hierarchies are used 
      // for path concatenation
      state.add_hdl_path_slice("stat_reg", 0, state.get_n_bits());
    `endif
    this.default_map.add_reg(this.state, `UVM_REG_ADDR_WIDTH'hc, "RO", 0);

    `ifdef BACKDOOR_MODE
      add_hdl_path("my_traffic");
    `endif
  endfunction 
endclass
