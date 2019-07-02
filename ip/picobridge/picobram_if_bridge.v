module PicoBramBridge
    #( parameter [31:0] C_DELAY = 1,
       parameter [0:0] C_USE_LOOKAHEAD = 0,
       parameter [31:0] C_ADDR_WIDTH = 32
       )
    (
     input                     CLK, 
     input                     RSTN,
    
     input                     MEM_VALID,
     input                     MEM_INSTR,
     output                    MEM_READY,

     input [31:0]              MEM_ADDR,
     input [31:0]              MEM_WDATA,
     input [ 3:0]              MEM_WSTRB,
     output [31:0]             MEM_RDATA,

	 // Look-Ahead Interface
     input                     MEM_LA_READ,
     input                     MEM_LA_WRITE,
     input [31:0]              MEM_LA_ADDR,
     input [31:0]              MEM_LA_WDATA,
     input [ 3:0]              MEM_LA_WSTRB,

     output [C_ADDR_WIDTH-1:0] BRAM_ADDR,
     output                    BRAM_CLK,
     output [31:0]             BRAM_DIN,
     input [31:0]              BRAM_DOUT,
     output                    BRAM_EN,
     output                    BRAM_RST,
     output [3:0]              BRAM_WE
     );

    reg [C_DELAY-1:0]            rDelay;
    wire [C_DELAY:0]             wDelay;

    assign wDelay = {rDelay, MEM_VALID};
    
    always @(posedge CLK) begin
        if (RSTN & ~(MEM_VALID & MEM_READY)) begin
            rDelay <= wDelay[C_DELAY-1:0];
        end else begin
            rDelay <= 0;
        end
    end
    
    assign BRAM_ADDR = C_USE_LOOKAHEAD ? MEM_LA_ADDR : MEM_ADDR;
    assign BRAM_CLK = CLK;
    assign BRAM_DIN = C_USE_LOOKAHEAD ? MEM_LA_WDATA : MEM_WDATA;
    assign BRAM_EN = C_USE_LOOKAHEAD ? 
                     MEM_LA_WRITE | MEM_LA_READ | MEM_VALID : 
                     wDelay[C_DELAY-1:0] != 0;

    assign BRAM_RST = ~RSTN;
    assign BRAM_WE = C_USE_LOOKAHEAD ? MEM_LA_WSTRB & {4{MEM_LA_WRITE}} : 
                     MEM_WSTRB;

    assign MEM_RDATA = BRAM_DOUT;    
    assign MEM_READY = C_USE_LOOKAHEAD ? wDelay[C_DELAY - 1] : wDelay[C_DELAY];
    
endmodule
