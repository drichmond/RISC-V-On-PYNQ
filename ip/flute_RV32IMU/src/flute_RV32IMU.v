module flute_RV32IMU(
                       // Beginning of automatic inputs (from unused autoinst inputs)
                       input           CLK,                    // To core_inst of mkCore.v
                       input           RST_N,                  // To core_inst of mkCore.v
                       input           M_AXI_DMEM_arready,// To core_inst of mkCore.v
                       input           M_AXI_DMEM_awready,// To core_inst of mkCore.v
                       input [3:0]     M_AXI_DMEM_bid,    // To core_inst of mkCore.v
                       input [1:0]     M_AXI_DMEM_bresp,  // To core_inst of mkCore.v
                       input           M_AXI_DMEM_bvalid, // To core_inst of mkCore.v
                       input [63:0]    M_AXI_DMEM_rdata,  // To core_inst of mkCore.v
                       input [3:0]     M_AXI_DMEM_rid,    // To core_inst of mkCore.v
                       input           M_AXI_DMEM_rlast,  // To core_inst of mkCore.v
                       input [1:0]     M_AXI_DMEM_rresp,  // To core_inst of mkCore.v
                       input           M_AXI_DMEM_rvalid, // To core_inst of mkCore.v
                       input           M_AXI_DMEM_wready, // To core_inst of mkCore.v
                       input           cpu_external_interrupt_req,// To core_inst of mkCore.v
                       input           M_AXI_IMEM_arready,// To core_inst of mkCore.v
                       input           M_AXI_IMEM_awready,// To core_inst of mkCore.v
                       input [3:0]     M_AXI_IMEM_bid,    // To core_inst of mkCore.v
                       input [1:0]     M_AXI_IMEM_bresp,  // To core_inst of mkCore.v
                       input           M_AXI_IMEM_bvalid, // To core_inst of mkCore.v
                       input [63:0]    M_AXI_IMEM_rdata,  // To core_inst of mkCore.v
                       input [3:0]     M_AXI_IMEM_rid,    // To core_inst of mkCore.v
                       input           M_AXI_IMEM_rlast,  // To core_inst of mkCore.v
                       input [1:0]     M_AXI_IMEM_rresp,  // To core_inst of mkCore.v
                       input           M_AXI_IMEM_rvalid, // To core_inst of mkCore.v
                       input           M_AXI_IMEM_wready, // To core_inst of mkCore.v
                       // End of automatics
                       // Beginning of automatic outputs (from unused autoinst outputs)
                       output [63:0]   M_AXI_DMEM_araddr, // From core_inst of mkCore.v
                       output [1:0]    M_AXI_DMEM_arburst,// From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_arcache,// From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_arid,   // From core_inst of mkCore.v
                       output [7:0]    M_AXI_DMEM_arlen,  // From core_inst of mkCore.v
                       output          M_AXI_DMEM_arlock, // From core_inst of mkCore.v
                       output [2:0]    M_AXI_DMEM_arprot, // From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_arqos,  // From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_arregion,// From core_inst of mkCore.v
                       output [2:0]    M_AXI_DMEM_arsize, // From core_inst of mkCore.v
                       output          M_AXI_DMEM_arvalid,// From core_inst of mkCore.v
                       output [63:0]   M_AXI_DMEM_awaddr, // From core_inst of mkCore.v
                       output [1:0]    M_AXI_DMEM_awburst,// From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_awcache,// From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_awid,   // From core_inst of mkCore.v
                       output [7:0]    M_AXI_DMEM_awlen,  // From core_inst of mkCore.v
                       output          M_AXI_DMEM_awlock, // From core_inst of mkCore.v
                       output [2:0]    M_AXI_DMEM_awprot, // From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_awqos,  // From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_awregion,// From core_inst of mkCore.v
                       output [2:0]    M_AXI_DMEM_awsize, // From core_inst of mkCore.v
                       output          M_AXI_DMEM_awvalid,// From core_inst of mkCore.v
                       output          M_AXI_DMEM_bready, // From core_inst of mkCore.v
                       output          M_AXI_DMEM_rready, // From core_inst of mkCore.v
                       output [63:0]   M_AXI_DMEM_wdata,  // From core_inst of mkCore.v
                       output [3:0]    M_AXI_DMEM_wid,    // From core_inst of mkCore.v
                       output          M_AXI_DMEM_wlast,  // From core_inst of mkCore.v
                       output [7:0]    M_AXI_DMEM_wstrb,  // From core_inst of mkCore.v
                       output          M_AXI_DMEM_wvalid, // From core_inst of mkCore.v
                       output [63:0]   M_AXI_IMEM_araddr, // From core_inst of mkCore.v
                       output [1:0]    M_AXI_IMEM_arburst,// From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_arcache,// From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_arid,   // From core_inst of mkCore.v
                       output [7:0]    M_AXI_IMEM_arlen,  // From core_inst of mkCore.v
                       output          M_AXI_IMEM_arlock, // From core_inst of mkCore.v
                       output [2:0]    M_AXI_IMEM_arprot, // From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_arqos,  // From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_arregion,// From core_inst of mkCore.v
                       output [2:0]    M_AXI_IMEM_arsize, // From core_inst of mkCore.v
                       output          M_AXI_IMEM_arvalid,// From core_inst of mkCore.v
                       output [63:0]   M_AXI_IMEM_awaddr, // From core_inst of mkCore.v
                       output [1:0]    M_AXI_IMEM_awburst,// From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_awcache,// From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_awid,   // From core_inst of mkCore.v
                       output [7:0]    M_AXI_IMEM_awlen,  // From core_inst of mkCore.v
                       output          M_AXI_IMEM_awlock, // From core_inst of mkCore.v
                       output [2:0]    M_AXI_IMEM_awprot, // From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_awqos,  // From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_awregion,// From core_inst of mkCore.v
                       output [2:0]    M_AXI_IMEM_awsize, // From core_inst of mkCore.v
                       output          M_AXI_IMEM_awvalid,// From core_inst of mkCore.v
                       output          M_AXI_IMEM_bready, // From core_inst of mkCore.v
                       output          M_AXI_IMEM_rready, // From core_inst of mkCore.v
                       output [63:0]   M_AXI_IMEM_wdata,  // From core_inst of mkCore.v
                       output [3:0]    M_AXI_IMEM_wid,    // From core_inst of mkCore.v
                       output          M_AXI_IMEM_wlast,  // From core_inst of mkCore.v
                       output [7:0]    M_AXI_IMEM_wstrb,  // From core_inst of mkCore.v
                       output          M_AXI_IMEM_wvalid // From core_inst of mkCore.v
                       // End of automatics
                       );


    wire                               RDY_cpu_reset_server_request_put;
    wire                               RDY_cpu_reset_server_response_get;
    wire                               EN_cpu_reset_server_request_put = RDY_cpu_reset_server_response_get;
    wire                               EN_cpu_reset_server_response_get;
    wire [63:0]                        cpu_slave_araddr;
    wire [1:0]                         cpu_slave_arburst;
    wire [3:0]                         cpu_slave_arcache;
    wire [3:0]                         cpu_slave_arid;
    wire [7:0]                         cpu_slave_arlen;
    wire                               cpu_slave_arlock;
    wire [2:0]                         cpu_slave_arprot;
    wire [3:0]                         cpu_slave_arqos;
    wire [3:0]                         cpu_slave_arregion;
    wire [2:0]                         cpu_slave_arsize;
    wire                               cpu_slave_arvalid;
    wire [63:0]                        cpu_slave_awaddr;
    wire [1:0]                         cpu_slave_awburst;
    wire [3:0]                         cpu_slave_awcache;
    wire [3:0]                         cpu_slave_awid;
    wire [7:0]                         cpu_slave_awlen;
    wire                               cpu_slave_awlock;
    wire [2:0]                         cpu_slave_awprot;
    wire [3:0]                         cpu_slave_awqos;
    wire [3:0]                         cpu_slave_awregion;
    wire [2:0]                         cpu_slave_awsize;
    wire                               cpu_slave_awvalid;
    wire                               cpu_slave_bready;
    wire                               cpu_slave_rready;
    wire [63:0]                        cpu_slave_wdata;
    wire [3:0]                         cpu_slave_wid;
    wire                               cpu_slave_wlast;
    wire [7:0]                         cpu_slave_wstrb;
    wire                               cpu_slave_wvalid;
    wire                               cpu_slave_arready;
    wire                               cpu_slave_awready;
    wire [3:0]                         cpu_slave_bid;
    wire [1:0]                         cpu_slave_bresp;
    wire                               cpu_slave_bvalid;
    wire [63:0]                        cpu_slave_rdata;
    wire [3:0]                         cpu_slave_rid;
    wire                               cpu_slave_rlast;
    wire [1:0]                         cpu_slave_rresp;
    wire                               cpu_slave_rvalid;
    wire                               cpu_slave_wready;

    wire                               EN_set_verbosity = 1'b0;
    wire [63:0]                        set_verbosity_logdelay = 64'h0;
    wire [3:0]                         set_verbosity_verbosity = 4'h0;
    wire                               RDY_set_verbosity;
    
    mkCore 
        core_inst
    (
     // Outputs
     .RDY_cpu_reset_server_request_put  (RDY_cpu_reset_server_request_put),
     .RDY_cpu_reset_server_response_get (RDY_cpu_reset_server_response_get),
     .cpu_imem_master_awvalid           (M_AXI_IMEM_awvalid),
     .cpu_imem_master_awid              (M_AXI_IMEM_awid[3:0]),
     .cpu_imem_master_awaddr            (M_AXI_IMEM_awaddr[63:0]),
     .cpu_imem_master_awlen             (M_AXI_IMEM_awlen[7:0]),
     .cpu_imem_master_awsize            (M_AXI_IMEM_awsize[2:0]),
     .cpu_imem_master_awburst           (M_AXI_IMEM_awburst[1:0]),
     .cpu_imem_master_awlock            (M_AXI_IMEM_awlock),
     .cpu_imem_master_awcache           (M_AXI_IMEM_awcache[3:0]),
     .cpu_imem_master_awprot            (M_AXI_IMEM_awprot[2:0]),
     .cpu_imem_master_awqos             (M_AXI_IMEM_awqos[3:0]),
     .cpu_imem_master_awregion          (M_AXI_IMEM_awregion[3:0]),
     .cpu_imem_master_wvalid            (M_AXI_IMEM_wvalid),
     .cpu_imem_master_wid               (M_AXI_IMEM_wid[3:0]),
     .cpu_imem_master_wdata             (M_AXI_IMEM_wdata[63:0]),
     .cpu_imem_master_wstrb             (M_AXI_IMEM_wstrb[7:0]),
     .cpu_imem_master_wlast             (M_AXI_IMEM_wlast),
     .cpu_imem_master_bready            (M_AXI_IMEM_bready),
     .cpu_imem_master_arvalid           (M_AXI_IMEM_arvalid),
     .cpu_imem_master_arid              (M_AXI_IMEM_arid[3:0]),
     .cpu_imem_master_araddr            (M_AXI_IMEM_araddr[63:0]),
     .cpu_imem_master_arlen             (M_AXI_IMEM_arlen[7:0]),
     .cpu_imem_master_arsize            (M_AXI_IMEM_arsize[2:0]),
     .cpu_imem_master_arburst           (M_AXI_IMEM_arburst[1:0]),
     .cpu_imem_master_arlock            (M_AXI_IMEM_arlock),
     .cpu_imem_master_arcache           (M_AXI_IMEM_arcache[3:0]),
     .cpu_imem_master_arprot            (M_AXI_IMEM_arprot[2:0]),
     .cpu_imem_master_arqos             (M_AXI_IMEM_arqos[3:0]),
     .cpu_imem_master_arregion          (M_AXI_IMEM_arregion[3:0]),
     .cpu_imem_master_rready            (M_AXI_IMEM_rready),
     .cpu_dmem_master_awvalid           (M_AXI_DMEM_awvalid),
     .cpu_dmem_master_awid              (M_AXI_DMEM_awid[3:0]),
     .cpu_dmem_master_awaddr            (M_AXI_DMEM_awaddr[63:0]),
     .cpu_dmem_master_awlen             (M_AXI_DMEM_awlen[7:0]),
     .cpu_dmem_master_awsize            (M_AXI_DMEM_awsize[2:0]),
     .cpu_dmem_master_awburst           (M_AXI_DMEM_awburst[1:0]),
     .cpu_dmem_master_awlock            (M_AXI_DMEM_awlock),
     .cpu_dmem_master_awcache           (M_AXI_DMEM_awcache[3:0]),
     .cpu_dmem_master_awprot            (M_AXI_DMEM_awprot[2:0]),
     .cpu_dmem_master_awqos             (M_AXI_DMEM_awqos[3:0]),
     .cpu_dmem_master_awregion          (M_AXI_DMEM_awregion[3:0]),
     .cpu_dmem_master_wvalid            (M_AXI_DMEM_wvalid),
     .cpu_dmem_master_wid               (M_AXI_DMEM_wid[3:0]),
     .cpu_dmem_master_wdata             (M_AXI_DMEM_wdata[63:0]),
     .cpu_dmem_master_wstrb             (M_AXI_DMEM_wstrb[7:0]),
     .cpu_dmem_master_wlast             (M_AXI_DMEM_wlast),
     .cpu_dmem_master_bready            (M_AXI_DMEM_bready),
     .cpu_dmem_master_arvalid           (M_AXI_DMEM_arvalid),
     .cpu_dmem_master_arid              (M_AXI_DMEM_arid[3:0]),
     .cpu_dmem_master_araddr            (M_AXI_DMEM_araddr[63:0]),
     .cpu_dmem_master_arlen             (M_AXI_DMEM_arlen[7:0]),
     .cpu_dmem_master_arsize            (M_AXI_DMEM_arsize[2:0]),
     .cpu_dmem_master_arburst           (M_AXI_DMEM_arburst[1:0]),
     .cpu_dmem_master_arlock            (M_AXI_DMEM_arlock),
     .cpu_dmem_master_arcache           (M_AXI_DMEM_arcache[3:0]),
     .cpu_dmem_master_arprot            (M_AXI_DMEM_arprot[2:0]),
     .cpu_dmem_master_arqos             (M_AXI_DMEM_arqos[3:0]),
     .cpu_dmem_master_arregion          (M_AXI_DMEM_arregion[3:0]),
     .cpu_dmem_master_rready            (M_AXI_DMEM_rready),
     .cpu_slave_awready                 (cpu_slave_awready),
     .cpu_slave_wready                  (cpu_slave_wready),
     .cpu_slave_bvalid                  (cpu_slave_bvalid),
     .cpu_slave_bid                     (cpu_slave_bid[3:0]),
     .cpu_slave_bresp                   (cpu_slave_bresp[1:0]),
     .cpu_slave_arready                 (cpu_slave_arready),
     .cpu_slave_rvalid                  (cpu_slave_rvalid),
     .cpu_slave_rid                     (cpu_slave_rid[3:0]),
     .cpu_slave_rdata                   (cpu_slave_rdata[63:0]),
     .cpu_slave_rresp                   (cpu_slave_rresp[1:0]),
     .cpu_slave_rlast                   (cpu_slave_rlast),
     .RDY_set_verbosity                 (RDY_set_verbosity),
     // Inputs
     .CLK                               (CLK),
     .RST_N                             (RST_N),
     .EN_cpu_reset_server_request_put   (EN_cpu_reset_server_request_put),
     .EN_cpu_reset_server_response_get  (EN_cpu_reset_server_response_get),
     .cpu_imem_master_awready           (M_AXI_IMEM_awready),
     .cpu_imem_master_wready            (M_AXI_IMEM_wready),
     .cpu_imem_master_bvalid            (M_AXI_IMEM_bvalid),
     .cpu_imem_master_bid               (M_AXI_IMEM_bid[3:0]),
     .cpu_imem_master_bresp             (M_AXI_IMEM_bresp[1:0]),
     .cpu_imem_master_arready           (M_AXI_IMEM_arready),
     .cpu_imem_master_rvalid            (M_AXI_IMEM_rvalid),
     .cpu_imem_master_rid               (M_AXI_IMEM_rid[3:0]),
     .cpu_imem_master_rdata             (M_AXI_IMEM_rdata[63:0]),
     .cpu_imem_master_rresp             (M_AXI_IMEM_rresp[1:0]),
     .cpu_imem_master_rlast             (M_AXI_IMEM_rlast),
     .cpu_dmem_master_awready           (M_AXI_DMEM_awready),
     .cpu_dmem_master_wready            (M_AXI_DMEM_wready),
     .cpu_dmem_master_bvalid            (M_AXI_DMEM_bvalid),
     .cpu_dmem_master_bid               (M_AXI_DMEM_bid[3:0]),
     .cpu_dmem_master_bresp             (M_AXI_DMEM_bresp[1:0]),
     .cpu_dmem_master_arready           (M_AXI_DMEM_arready),
     .cpu_dmem_master_rvalid            (M_AXI_DMEM_rvalid),
     .cpu_dmem_master_rid               (M_AXI_DMEM_rid[3:0]),
     .cpu_dmem_master_rdata             (M_AXI_DMEM_rdata[63:0]),
     .cpu_dmem_master_rresp             (M_AXI_DMEM_rresp[1:0]),
     .cpu_dmem_master_rlast             (M_AXI_DMEM_rlast),
     .cpu_slave_awvalid                 (cpu_slave_awvalid),
     .cpu_slave_awid                    (cpu_slave_awid[3:0]),
     .cpu_slave_awaddr                  (cpu_slave_awaddr[63:0]),
     .cpu_slave_awlen                   (cpu_slave_awlen[7:0]),
     .cpu_slave_awsize                  (cpu_slave_awsize[2:0]),
     .cpu_slave_awburst                 (cpu_slave_awburst[1:0]),
     .cpu_slave_awlock                  (cpu_slave_awlock),
     .cpu_slave_awcache                 (cpu_slave_awcache[3:0]),
     .cpu_slave_awprot                  (cpu_slave_awprot[2:0]),
     .cpu_slave_awqos                   (cpu_slave_awqos[3:0]),
     .cpu_slave_awregion                (cpu_slave_awregion[3:0]),
     .cpu_slave_wvalid                  (cpu_slave_wvalid),
     .cpu_slave_wid                     (cpu_slave_wid[3:0]),
     .cpu_slave_wdata                   (cpu_slave_wdata[63:0]),
     .cpu_slave_wstrb                   (cpu_slave_wstrb[7:0]),
     .cpu_slave_wlast                   (cpu_slave_wlast),
     .cpu_slave_bready                  (cpu_slave_bready),
     .cpu_slave_arvalid                 (cpu_slave_arvalid),
     .cpu_slave_arid                    (cpu_slave_arid[3:0]),
     .cpu_slave_araddr                  (cpu_slave_araddr[63:0]),
     .cpu_slave_arlen                   (cpu_slave_arlen[7:0]),
     .cpu_slave_arsize                  (cpu_slave_arsize[2:0]),
     .cpu_slave_arburst                 (cpu_slave_arburst[1:0]),
     .cpu_slave_arlock                  (cpu_slave_arlock),
     .cpu_slave_arcache                 (cpu_slave_arcache[3:0]),
     .cpu_slave_arprot                  (cpu_slave_arprot[2:0]),
     .cpu_slave_arqos                   (cpu_slave_arqos[3:0]),
     .cpu_slave_arregion                (cpu_slave_arregion[3:0]),
     .cpu_slave_rready                  (cpu_slave_rready),
     .cpu_external_interrupt_req_set_not_clear(cpu_external_interrupt),
     .set_verbosity_verbosity           (set_verbosity_verbosity[3:0]),
     .set_verbosity_logdelay            (set_verbosity_logdelay[63:0]),
     .EN_set_verbosity                  (EN_set_verbosity));
    
endmodule
