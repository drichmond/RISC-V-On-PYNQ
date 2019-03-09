module flute_RV32IMU(
                     // Beginning of automatic inputs (from unused autoinst inputs)
                     input         CLK,
                     input         RST_N,
                     input         M_AXI_DMEM_arready,
                     input         M_AXI_DMEM_awready,
                     input [1:0]   M_AXI_DMEM_bresp,
                     input         M_AXI_DMEM_bvalid,
                     input [63:0]  M_AXI_DMEM_rdata,
                     input [1:0]   M_AXI_DMEM_rresp,
                     input         M_AXI_DMEM_rvalid,
                     input         M_AXI_DMEM_wready,
                     input         cpu_external_interrupt,
                     input         M_AXI_IMEM_arready,
                     input         M_AXI_IMEM_awready,
                     input [1:0]   M_AXI_IMEM_bresp,
                     input         M_AXI_IMEM_bvalid,
                     input [63:0]  M_AXI_IMEM_rdata,
                     input [1:0]   M_AXI_IMEM_rresp,
                     input         M_AXI_IMEM_rvalid,
                     input         M_AXI_IMEM_wready,
                     // End of automatics
                     /*AUTOOUTPUT*/
                     // Beginning of automatic outputs (from unused autoinst outputs)
                     output [63:0] M_AXI_DMEM_araddr,
                     output [2:0]  M_AXI_DMEM_arprot,
                     output        M_AXI_DMEM_arvalid,
                     output [63:0] M_AXI_DMEM_awaddr,
                     output [2:0]  M_AXI_DMEM_awprot,
                     output        M_AXI_DMEM_awvalid,
                     output        M_AXI_DMEM_bready,
                     output        M_AXI_DMEM_rready,
                     output [63:0] M_AXI_DMEM_wdata,
                     output [7:0]  M_AXI_DMEM_wstrb,
                     output        M_AXI_DMEM_wvalid,
                     output [63:0] M_AXI_IMEM_araddr,
                     output [2:0]  M_AXI_IMEM_arprot,
                     output        M_AXI_IMEM_arvalid,
                     output [63:0] M_AXI_IMEM_awaddr,
                     output [2:0]  M_AXI_IMEM_awprot,
                     output        M_AXI_IMEM_awvalid,
                     output        M_AXI_IMEM_bready,
                     output        M_AXI_IMEM_rready,
                     output [63:0] M_AXI_IMEM_wdata,
                     output [7:0]  M_AXI_IMEM_wstrb,
                     output        M_AXI_IMEM_wvalid
                     // End of automatics
                     );
    


    wire                           RDY_cpu_reset_server_request_put;
    wire                           RDY_cpu_reset_server_response_get;
    wire                           EN_cpu_reset_server_request_put = RDY_cpu_reset_server_response_get;
    wire                           EN_cpu_reset_server_response_get;

    wire                           EN_set_verbosity = 1'b0;
    wire [63:0]                    set_verbosity_logdelay = 64'h0;
    wire [3:0]                     set_verbosity_verbosity = 4'h0;
    wire                           RDY_set_verbosity;
    
    mkCore 
        core_inst
            (
             // Outputs
             .RDY_cpu_reset_server_request_put  (RDY_cpu_reset_server_request_put),
             .RDY_cpu_reset_server_response_get (RDY_cpu_reset_server_response_get),
             .cpu_imem_master_awvalid           (M_AXI_IMEM_awvalid),
             .cpu_imem_master_awaddr            (M_AXI_IMEM_awaddr[63:0]),
             .cpu_imem_master_awprot            (M_AXI_IMEM_awprot[2:0]),
             .cpu_imem_master_wvalid            (M_AXI_IMEM_wvalid),
             .cpu_imem_master_wdata             (M_AXI_IMEM_wdata[63:0]),
             .cpu_imem_master_wstrb             (M_AXI_IMEM_wstrb[7:0]),
             .cpu_imem_master_bready            (M_AXI_IMEM_bready),
             .cpu_imem_master_arvalid           (M_AXI_IMEM_arvalid),
             .cpu_imem_master_araddr            (M_AXI_IMEM_araddr[63:0]),
             .cpu_imem_master_arprot            (M_AXI_IMEM_arprot[2:0]),
             .cpu_imem_master_rready            (M_AXI_IMEM_rready),
             .cpu_dmem_master_awvalid           (M_AXI_DMEM_awvalid),
             .cpu_dmem_master_awaddr            (M_AXI_DMEM_awaddr[63:0]),
             .cpu_dmem_master_awprot            (M_AXI_DMEM_awprot[2:0]),
             .cpu_dmem_master_wvalid            (M_AXI_DMEM_wvalid),
             .cpu_dmem_master_wdata             (M_AXI_DMEM_wdata[63:0]),
             .cpu_dmem_master_wstrb             (M_AXI_DMEM_wstrb[7:0]),
             .cpu_dmem_master_bready            (M_AXI_DMEM_bready),
             .cpu_dmem_master_arvalid           (M_AXI_DMEM_arvalid),
             .cpu_dmem_master_araddr            (M_AXI_DMEM_araddr[63:0]),
             .cpu_dmem_master_arprot            (M_AXI_DMEM_arprot[2:0]),
             .cpu_dmem_master_rready            (M_AXI_DMEM_rready),
             .RDY_set_verbosity                 (RDY_set_verbosity),
             // Inputs
             .CLK                               (CLK),
             .RST_N                             (RST_N),
             .EN_cpu_reset_server_request_put   (EN_cpu_reset_server_request_put),
             .EN_cpu_reset_server_response_get  (EN_cpu_reset_server_response_get),
             .cpu_imem_master_awready           (M_AXI_IMEM_awready),
             .cpu_imem_master_wready            (M_AXI_IMEM_wready),
             .cpu_imem_master_bvalid            (M_AXI_IMEM_bvalid),
             .cpu_imem_master_bresp             (M_AXI_IMEM_bresp[1:0]),
             .cpu_imem_master_arready           (M_AXI_IMEM_arready),
             .cpu_imem_master_rvalid            (M_AXI_IMEM_rvalid),
             .cpu_imem_master_rresp             (M_AXI_IMEM_rresp[1:0]),
             .cpu_imem_master_rdata             (M_AXI_IMEM_rdata[63:0]),
             .cpu_dmem_master_awready           (M_AXI_DMEM_awready),
             .cpu_dmem_master_wready            (M_AXI_DMEM_wready),
             .cpu_dmem_master_bvalid            (M_AXI_DMEM_bvalid),
             .cpu_dmem_master_bresp             (M_AXI_DMEM_bresp[1:0]),
             .cpu_dmem_master_arready           (M_AXI_DMEM_arready),
             .cpu_dmem_master_rvalid            (M_AXI_DMEM_rvalid),
             .cpu_dmem_master_rresp             (M_AXI_DMEM_rresp[1:0]),
             .cpu_dmem_master_rdata             (M_AXI_DMEM_rdata[63:0]),
             .cpu_external_interrupt_req_set_not_clear(cpu_external_interrupt),
             .set_verbosity_verbosity           (set_verbosity_verbosity[3:0]),
             .set_verbosity_logdelay            (set_verbosity_logdelay[63:0]),
             .EN_set_verbosity                  (EN_set_verbosity));
    
endmodule
