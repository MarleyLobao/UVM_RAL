import traffic_pkg::*;

module traffic_top;

  logic clk;

  initial clk = 1;

  always #10 clk = !clk;

  apb_if vif_top(.pclk(clk));
  
  traffic my_traffic(
          .pclk(clk),
          .presetn(vif_top.presetn),
          .paddr(vif_top.paddr),
          .pwdata(vif_top.pwdata),
          .psel(vif_top.psel),
          .pwrite(vif_top.pwrite),
          .penable(vif_top.penable),
          .prdata(vif_top.prdata)
  );

  initial begin
    uvm_config_db#(virtual apb_if)::set(uvm_root::get(), "*", "vif", vif_top);
    run_test("traffic_base_test");
  end
endmodule
