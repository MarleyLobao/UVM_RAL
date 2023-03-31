class ral_reg_block_sys extends uvm_reg_block;
  rand ral_reg_block_cfg cfg;

  `uvm_object_utils(ral_reg_block_sys)

  function new(string name = "ral_reg_block_sys");
    super.new(name);
  endfunction

  function void build();
    this.default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN, 0);
    this.cfg = ral_reg_block_cfg::type_id::create("cfg",,get_full_name());
    this.cfg.configure(this, "tb_top.pB0");
    this.cfg.build();
    this.default_map.add_submap(this.cfg.default_map, `UVM_REG_ADDR_WIDTH'h0);
  endfunction
endclass
