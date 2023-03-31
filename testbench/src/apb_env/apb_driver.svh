// Drives a given apb transaction packet to the APB interface
class apb_driver extends uvm_driver #(apb_seq_item);
   `uvm_component_utils (apb_driver)

   apb_seq_item  pkt;

   virtual apb_if vif_driver;

   function new (string name = "apb_driver", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      if (! uvm_config_db#(virtual apb_if)::get (this, "*", "vif", vif_driver))
         `uvm_error ("DRVR", "Did not get bus if handle")
   endfunction

   virtual task run_phase (uvm_phase phase);
      bit [31:0] data;

      vif_driver.psel <= 0;
      vif_driver.penable <= 0;
      vif_driver.pwrite <= 0;
      vif_driver.paddr <= 0;
      vif_driver.pwdata <= 0;
      forever begin
         seq_item_port.get_next_item (pkt);
         if (pkt.write)
            write (pkt.addr, pkt.data);
         else begin
            read (pkt.addr, data);
            pkt.data = data;
         end
         seq_item_port.item_done ();
      end
   endtask

   virtual task read (  input bit    [31:0] addr, 
                        output logic [31:0] data);
      vif_driver.paddr <= addr;
      vif_driver.pwrite <= 0;
      vif_driver.psel <= 1;
      @(posedge vif_driver.pclk);
      vif_driver.penable <= 1;
      @(posedge vif_driver.pclk);
      data = vif_driver.prdata;
      vif_driver.psel <= 0;
      vif_driver.penable <= 0;
   endtask

   virtual task write ( input bit [31:0] addr,
                        input bit [31:0] data);
      vif_driver.paddr <= addr;
      vif_driver.pwdata <= data;
      vif_driver.pwrite <= 1;
      vif_driver.psel <= 1;
      @(posedge vif_driver.pclk);
      vif_driver.penable <= 1;
      @(posedge vif_driver.pclk);
      vif_driver.psel <= 0;
      vif_driver.penable <= 0;
   endtask
endclass
