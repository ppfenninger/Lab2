//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`include "shiftregister.v"
module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
    
    initial begin
        $dumpfile("shiftregister.vcd");
        $dumpvars();

        serialDataIn = 0;
        parallelDataIn = 8'b10101010;
        #5 clk=1; parallelLoad = 1; #5 clk=0; #5 clk=1; parallelLoad=0; #5 clk=0;

        // Test 1: parallel loading
        if(parallelDataOut !== 8'b10101010)
            $display("Test Case 1 Failed");

        // Test 2: serialDataOut is MSB
        if(serialDataOut !== 1'b1)
            $display("Test Case 2 Failed");

        #5 clk=1; peripheralClkEdge=1; #5 clk=0; #5 clk=1; peripheralClkEdge=0; #5 clk=0;

    	// Test 3: Data gets shifted
        if(parallelDataOut !== 8'b01010100)
            $display("Test Case 3 Failed");

        // Test 4: Parallel Loading takes priority
        serialDataIn = 1;
        parallelDataIn = 8'b11110000;
        #5 clk=1; parallelLoad=1; peripheralClkEdge=1; 
        #5 clk=0; 
        #5 clk=1; parallelLoad=0; peripheralClkEdge=0; 
        #5 clk=0;

        if(parallelDataOut !== 8'b11110000)
            $display("Test Case 4 Failed");





    end

endmodule

