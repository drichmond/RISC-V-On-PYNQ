module piccolo_RV32IMU(
                       // Beginning of automatic inputs (from unused autoinst inputs)
                       input           CLK,                    // To core_inst of mkCore.v
                       input           RST_N,                  // To core_inst of mkCore.v
                       input           cpu_dmem_master_arready,// To core_inst of mkCore.v
                       input           cpu_dmem_master_awready,// To core_inst of mkCore.v
                       input [3:0]     cpu_dmem_master_bid,    // To core_inst of mkCore.v
                       input [1:0]     cpu_dmem_master_bresp,  // To core_inst of mkCore.v
                       input           cpu_dmem_master_bvalid, // To core_inst of mkCore.v
                       input [63:0]    cpu_dmem_master_rdata,  // To core_inst of mkCore.v
                       input [3:0]     cpu_dmem_master_rid,    // To core_inst of mkCore.v
                       input           cpu_dmem_master_rlast,  // To core_inst of mkCore.v
                       input [1:0]     cpu_dmem_master_rresp,  // To core_inst of mkCore.v
                       input           cpu_dmem_master_rvalid, // To core_inst of mkCore.v
                       input           cpu_dmem_master_wready, // To core_inst of mkCore.v
                       input           cpu_external_interrupt_req,// To core_inst of mkCore.v
                       input           cpu_imem_master_arready,// To core_inst of mkCore.v
                       input           cpu_imem_master_awready,// To core_inst of mkCore.v
                       input [3:0]     cpu_imem_master_bid,    // To core_inst of mkCore.v
                       input [1:0]     cpu_imem_master_bresp,  // To core_inst of mkCore.v
                       input           cpu_imem_master_bvalid, // To core_inst of mkCore.v
                       input [63:0]    cpu_imem_master_rdata,  // To core_inst of mkCore.v
                       input [3:0]     cpu_imem_master_rid,    // To core_inst of mkCore.v
                       input           cpu_imem_master_rlast,  // To core_inst of mkCore.v
                       input [1:0]     cpu_imem_master_rresp,  // To core_inst of mkCore.v
                       input           cpu_imem_master_rvalid, // To core_inst of mkCore.v
                       input           cpu_imem_master_wready, // To core_inst of mkCore.v
                       // End of automatics
                       // Beginning of automatic outputs (from unused autoinst outputs)
                       output [63:0]   cpu_dmem_master_araddr, // From core_inst of mkCore.v
                       output [1:0]    cpu_dmem_master_arburst,// From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_arcache,// From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_arid,   // From core_inst of mkCore.v
                       output [7:0]    cpu_dmem_master_arlen,  // From core_inst of mkCore.v
                       output          cpu_dmem_master_arlock, // From core_inst of mkCore.v
                       output [2:0]    cpu_dmem_master_arprot, // From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_arqos,  // From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_arregion,// From core_inst of mkCore.v
                       output [2:0]    cpu_dmem_master_arsize, // From core_inst of mkCore.v
                       output          cpu_dmem_master_arvalid,// From core_inst of mkCore.v
                       output [63:0]   cpu_dmem_master_awaddr, // From core_inst of mkCore.v
                       output [1:0]    cpu_dmem_master_awburst,// From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_awcache,// From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_awid,   // From core_inst of mkCore.v
                       output [7:0]    cpu_dmem_master_awlen,  // From core_inst of mkCore.v
                       output          cpu_dmem_master_awlock, // From core_inst of mkCore.v
                       output [2:0]    cpu_dmem_master_awprot, // From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_awqos,  // From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_awregion,// From core_inst of mkCore.v
                       output [2:0]    cpu_dmem_master_awsize, // From core_inst of mkCore.v
                       output          cpu_dmem_master_awvalid,// From core_inst of mkCore.v
                       output          cpu_dmem_master_bready, // From core_inst of mkCore.v
                       output          cpu_dmem_master_rready, // From core_inst of mkCore.v
                       output [63:0]   cpu_dmem_master_wdata,  // From core_inst of mkCore.v
                       output [3:0]    cpu_dmem_master_wid,    // From core_inst of mkCore.v
                       output          cpu_dmem_master_wlast,  // From core_inst of mkCore.v
                       output [7:0]    cpu_dmem_master_wstrb,  // From core_inst of mkCore.v
                       output          cpu_dmem_master_wvalid, // From core_inst of mkCore.v
                       output [63:0]   cpu_imem_master_araddr, // From core_inst of mkCore.v
                       output [1:0]    cpu_imem_master_arburst,// From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_arcache,// From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_arid,   // From core_inst of mkCore.v
                       output [7:0]    cpu_imem_master_arlen,  // From core_inst of mkCore.v
                       output          cpu_imem_master_arlock, // From core_inst of mkCore.v
                       output [2:0]    cpu_imem_master_arprot, // From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_arqos,  // From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_arregion,// From core_inst of mkCore.v
                       output [2:0]    cpu_imem_master_arsize, // From core_inst of mkCore.v
                       output          cpu_imem_master_arvalid,// From core_inst of mkCore.v
                       output [63:0]   cpu_imem_master_awaddr, // From core_inst of mkCore.v
                       output [1:0]    cpu_imem_master_awburst,// From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_awcache,// From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_awid,   // From core_inst of mkCore.v
                       output [7:0]    cpu_imem_master_awlen,  // From core_inst of mkCore.v
                       output          cpu_imem_master_awlock, // From core_inst of mkCore.v
                       output [2:0]    cpu_imem_master_awprot, // From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_awqos,  // From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_awregion,// From core_inst of mkCore.v
                       output [2:0]    cpu_imem_master_awsize, // From core_inst of mkCore.v
                       output          cpu_imem_master_awvalid,// From core_inst of mkCore.v
                       output          cpu_imem_master_bready, // From core_inst of mkCore.v
                       output          cpu_imem_master_rready, // From core_inst of mkCore.v
                       output [63:0]   cpu_imem_master_wdata,  // From core_inst of mkCore.v
                       output [3:0]    cpu_imem_master_wid,    // From core_inst of mkCore.v
                       output          cpu_imem_master_wlast,  // From core_inst of mkCore.v
                       output [7:0]    cpu_imem_master_wstrb,  // From core_inst of mkCore.v
                       output          cpu_imem_master_wvalid // From core_inst of mkCore.v
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
     .cpu_imem_master_awvalid           (cpu_imem_master_awvalid),
     .cpu_imem_master_awid              (cpu_imem_master_awid[3:0]),
     .cpu_imem_master_awaddr            (cpu_imem_master_awaddr[63:0]),
     .cpu_imem_master_awlen             (cpu_imem_master_awlen[7:0]),
     .cpu_imem_master_awsize            (cpu_imem_master_awsize[2:0]),
     .cpu_imem_master_awburst           (cpu_imem_master_awburst[1:0]),
     .cpu_imem_master_awlock            (cpu_imem_master_awlock),
     .cpu_imem_master_awcache           (cpu_imem_master_awcache[3:0]),
     .cpu_imem_master_awprot            (cpu_imem_master_awprot[2:0]),
     .cpu_imem_master_awqos             (cpu_imem_master_awqos[3:0]),
     .cpu_imem_master_awregion          (cpu_imem_master_awregion[3:0]),
     .cpu_imem_master_wvalid            (cpu_imem_master_wvalid),
     .cpu_imem_master_wid               (cpu_imem_master_wid[3:0]),
     .cpu_imem_master_wdata             (cpu_imem_master_wdata[63:0]),
     .cpu_imem_master_wstrb             (cpu_imem_master_wstrb[7:0]),
     .cpu_imem_master_wlast             (cpu_imem_master_wlast),
     .cpu_imem_master_bready            (cpu_imem_master_bready),
     .cpu_imem_master_arvalid           (cpu_imem_master_arvalid),
     .cpu_imem_master_arid              (cpu_imem_master_arid[3:0]),
     .cpu_imem_master_araddr            (cpu_imem_master_araddr[63:0]),
     .cpu_imem_master_arlen             (cpu_imem_master_arlen[7:0]),
     .cpu_imem_master_arsize            (cpu_imem_master_arsize[2:0]),
     .cpu_imem_master_arburst           (cpu_imem_master_arburst[1:0]),
     .cpu_imem_master_arlock            (cpu_imem_master_arlock),
     .cpu_imem_master_arcache           (cpu_imem_master_arcache[3:0]),
     .cpu_imem_master_arprot            (cpu_imem_master_arprot[2:0]),
     .cpu_imem_master_arqos             (cpu_imem_master_arqos[3:0]),
     .cpu_imem_master_arregion          (cpu_imem_master_arregion[3:0]),
     .cpu_imem_master_rready            (cpu_imem_master_rready),
     .cpu_dmem_master_awvalid           (cpu_dmem_master_awvalid),
     .cpu_dmem_master_awid              (cpu_dmem_master_awid[3:0]),
     .cpu_dmem_master_awaddr            (cpu_dmem_master_awaddr[63:0]),
     .cpu_dmem_master_awlen             (cpu_dmem_master_awlen[7:0]),
     .cpu_dmem_master_awsize            (cpu_dmem_master_awsize[2:0]),
     .cpu_dmem_master_awburst           (cpu_dmem_master_awburst[1:0]),
     .cpu_dmem_master_awlock            (cpu_dmem_master_awlock),
     .cpu_dmem_master_awcache           (cpu_dmem_master_awcache[3:0]),
     .cpu_dmem_master_awprot            (cpu_dmem_master_awprot[2:0]),
     .cpu_dmem_master_awqos             (cpu_dmem_master_awqos[3:0]),
     .cpu_dmem_master_awregion          (cpu_dmem_master_awregion[3:0]),
     .cpu_dmem_master_wvalid            (cpu_dmem_master_wvalid),
     .cpu_dmem_master_wid               (cpu_dmem_master_wid[3:0]),
     .cpu_dmem_master_wdata             (cpu_dmem_master_wdata[63:0]),
     .cpu_dmem_master_wstrb             (cpu_dmem_master_wstrb[7:0]),
     .cpu_dmem_master_wlast             (cpu_dmem_master_wlast),
     .cpu_dmem_master_bready            (cpu_dmem_master_bready),
     .cpu_dmem_master_arvalid           (cpu_dmem_master_arvalid),
     .cpu_dmem_master_arid              (cpu_dmem_master_arid[3:0]),
     .cpu_dmem_master_araddr            (cpu_dmem_master_araddr[63:0]),
     .cpu_dmem_master_arlen             (cpu_dmem_master_arlen[7:0]),
     .cpu_dmem_master_arsize            (cpu_dmem_master_arsize[2:0]),
     .cpu_dmem_master_arburst           (cpu_dmem_master_arburst[1:0]),
     .cpu_dmem_master_arlock            (cpu_dmem_master_arlock),
     .cpu_dmem_master_arcache           (cpu_dmem_master_arcache[3:0]),
     .cpu_dmem_master_arprot            (cpu_dmem_master_arprot[2:0]),
     .cpu_dmem_master_arqos             (cpu_dmem_master_arqos[3:0]),
     .cpu_dmem_master_arregion          (cpu_dmem_master_arregion[3:0]),
     .cpu_dmem_master_rready            (cpu_dmem_master_rready),
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
     .cpu_imem_master_awready           (cpu_imem_master_awready),
     .cpu_imem_master_wready            (cpu_imem_master_wready),
     .cpu_imem_master_bvalid            (cpu_imem_master_bvalid),
     .cpu_imem_master_bid               (cpu_imem_master_bid[3:0]),
     .cpu_imem_master_bresp             (cpu_imem_master_bresp[1:0]),
     .cpu_imem_master_arready           (cpu_imem_master_arready),
     .cpu_imem_master_rvalid            (cpu_imem_master_rvalid),
     .cpu_imem_master_rid               (cpu_imem_master_rid[3:0]),
     .cpu_imem_master_rdata             (cpu_imem_master_rdata[63:0]),
     .cpu_imem_master_rresp             (cpu_imem_master_rresp[1:0]),
     .cpu_imem_master_rlast             (cpu_imem_master_rlast),
     .cpu_dmem_master_awready           (cpu_dmem_master_awready),
     .cpu_dmem_master_wready            (cpu_dmem_master_wready),
     .cpu_dmem_master_bvalid            (cpu_dmem_master_bvalid),
     .cpu_dmem_master_bid               (cpu_dmem_master_bid[3:0]),
     .cpu_dmem_master_bresp             (cpu_dmem_master_bresp[1:0]),
     .cpu_dmem_master_arready           (cpu_dmem_master_arready),
     .cpu_dmem_master_rvalid            (cpu_dmem_master_rvalid),
     .cpu_dmem_master_rid               (cpu_dmem_master_rid[3:0]),
     .cpu_dmem_master_rdata             (cpu_dmem_master_rdata[63:0]),
     .cpu_dmem_master_rresp             (cpu_dmem_master_rresp[1:0]),
     .cpu_dmem_master_rlast             (cpu_dmem_master_rlast),
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
