//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`include "shiftregister.v"
module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[3:0]       parallelDataOut;
    wire            serialDataOut;
    reg[3:0]        parallelDataIn;
    reg             serialDataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(4) dut(.clk(clk), 
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
        parallelDataIn = 4'b1010;
        #5 clk=1; parallelLoad = 1; #5 clk=0; #5 clk=1; parallelLoad=0; #5 clk=0;

        // Test 1: parallel loading
        if(parallelDataOut !== 4'b1010)
            $display("Test Case 1 Failed");

        // Test 2: serialDataOut is MSB
        if(serialDataOut !== 1'b1)
            $display("Test Case 2 Failed");

        #5 clk=1; peripheralClkEdge=1; #5 clk=0; #5 clk=1; peripheralClkEdge=0; #5 clk=0;

    	// Test 3: Data gets shifted
        if(parallelDataOut !== 4'b0100)
            $display("Test Case 3 Failed");

        // Test 4: Parallel Loading takes priority
        serialDataIn = 1;
        parallelDataIn = 4'b1100;
        #5 clk=1; parallelLoad=1; peripheralClkEdge=1; 
        #5 clk=0; 
        #5 clk=1; parallelLoad=0; peripheralClkEdge=0; 
        #5 clk=0;

        if(parallelDataOut !== 4'b1100)
            $display("Test Case 4 Failed");





    end

endmodule

