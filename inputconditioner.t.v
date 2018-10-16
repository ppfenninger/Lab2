//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------
`include "inputconditioner.v"

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    
    inputconditioner dut(.clk(clk),
    			 .noisysignal(pin),
			 .conditioned(conditioned),
			 .positiveedge(rising),
			 .negativeedge(falling));


    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    
    initial begin
        $dumpfile("input_conditioner.vcd");
        $dumpvars();
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronization, Debouncing, Edge Detection

    //Test 1 - Synchronization
    //Does it actually take five and a half clock cycles (20 units of time each) to get to the output
        pin=0; #80
        if((conditioned !== 0)) begin
            $display("Test Case 1a Failed: %b", conditioned);
        end
        pin=1; #120
        if((conditioned !== 1)) begin 
            $display("Test Case 1b Failed: %b", conditioned);
        end
        pin=0; #100
        if((conditioned !== 1)) begin
            $display("Test Case 1c Failed: %b", conditioned);
        end
        #20
        if((conditioned !== 0)) begin
            $display("Test Case 1d Failed: %b", conditioned);
        end
        pin=1; #100
        if((conditioned !== 0)) begin 
            $display("Test Case 1e Failed: %b", conditioned);
        end
        #20
        if((conditioned !== 1)) begin
            $display("Test Case 1f Failed: %b", conditioned);
        end

    //Test 2 - Debouncing
    //Does the output hold when there is a very noisy input signal
        pin=0; #120
        if((conditioned !== 0)) begin
            $display("Test Case 2a Failed: %b", conditioned);
        end
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        if((conditioned !== 0)) begin
            $display("Test Case 2b Failed: %b", conditioned);
        end
        pin=1; #120
        if((conditioned !== 1)) begin
            $display("Test Case 2c Failed: %b", conditioned);
        end
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        pin=0; #10
        pin=1; #10
        if((conditioned !== 1)) begin
            $display("Test Case 2d Failed: %b", conditioned);
        end
        pin=0; #120
        if((conditioned !== 0)) begin
            $display("Test Case 2e Failed: %b", conditioned);
        end

    //Test 3 - Edge Detection
    //Does the positive edge and negative edge go high when needed
        pin=1; #120
        if((conditioned !== 1)) begin
            $display("Test Case 3a Failed: %b", conditioned);
        end
        if((rising !== 1) && (falling !== 0)) begin
            $display("Test Case 3b Failed: %b, %b", rising, falling);
        end
        #20
        if((rising !== 0) && (falling !== 0)) begin
            $display("Test Case 3c Failed: %b, %b", rising, falling);
        end

        pin=0; #120
        if((conditioned !== 0)) begin
            $display("Test Case 3d Failed: %b", conditioned);
        end
        if((rising !== 0) && (falling !== 1)) begin
            $display("Test Case 3e Failed: %b, %b", rising, falling);
        end
        #20
        if((rising !== 0) && (falling !== 0)) begin
            $display("Test Case 3f Failed: %b, %b", rising, falling);
        end





    $display("Testing Done");
    end
endmodule