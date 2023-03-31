// Monitors the APB interface for any activity and reports out
// through an analysis port
class apb_monitor extends uvm_monitor;
   `uvm_component_utils (apb_monitor)

   function new (string name="apb_monitor", uvm_component parent);
      super.new (name, parent);
   endfunction

   uvm_analysis_port #(apb_seq_item) mon_ap;
   virtual apb_if vif_monitor;

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      mon_ap = new ("mon_ap", this);
      if (! uvm_config_db #(virtual apb_if)::get (null, "uvm_test_top.*", "vif", vif_monitor))
         `uvm_error ("MONTR", "Did not get bus if handle")
   endfunction
   
   virtual task run_phase (uvm_phase phase);
      fork
         forever begin
            @(posedge vif_monitor.pclk);
            if (vif_monitor.psel & vif_monitor.penable & vif_monitor.presetn) begin
               apb_seq_item pkt = apb_seq_item::type_id::create ("pkt");
               pkt.addr = vif_monitor.paddr;
               if (vif_monitor.pwrite)
                  pkt.data = vif_monitor.pwdata;
               else
                  pkt.data = vif_monitor.prdata;
               pkt.write = vif_monitor.pwrite;
               mon_ap.write (pkt);
            end 
         end
      join_none
   endtask
endclass
