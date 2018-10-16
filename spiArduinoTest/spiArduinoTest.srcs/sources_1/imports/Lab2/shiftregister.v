//------------------------------------------------------------------------
// Shift Register
//   Parameterized width (in bits)
//   Shift register can operate in two modes:
//      - serial in, parallel out
//      - parallel in, serial out
//------------------------------------------------------------------------

module shiftregister
#(parameter width = 8)
(
input               clk,                // FPGA Clock
input               peripheralClkEdge,  // Edge indicator
input               parallelLoad,       // 1 = Load shift reg with parallelDataIn
input  [width-1:0]  parallelDataIn,     // Load shift reg in parallel
input               serialDataIn,       // Load shift reg serially
output [width-1:0]  parallelDataOut,    // Shift reg data contents
output              serialDataOut       // Positive edge synchronized
);
	integer i;
    reg [width-1:0]      shiftregistermem;
    always @(posedge clk) begin
        if (parallelLoad) begin //ParallelLoad gets priority
        	for (i = 0; i < width; i = i+1)
        		shiftregistermem[i] <= parallelDataIn[width-1-i];
        end // if (parallelLoad)
        else if(peripheralClkEdge) begin
        	shiftregistermem[0] <= serialDataIn;
        	for (i=1; i<width; i=i+1) begin
        		shiftregistermem[i] <= shiftregistermem[i-1];
        	end // for (i=0; i<width-1; i=i+1)
        end // else
    end
    assign parallelDataOut = shiftregistermem;
    assign serialDataOut   = shiftregistermem[width-1];

endmodule