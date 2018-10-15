`include "spimemory.v"

module test_spimemory();
	reg clk;
	reg sclk_pin;
	reg cs_pin;
	reg mosi_pin;
	wire miso_pin;
	wire[3:0] leds;

	spiMemory dut(
		.clk(clk),
		.sclk_pin(sclk_pin),
		.cs_pin(cs_pin),
		.mosi_pin(mosi_pin),
		.miso_pin(miso_pin),
		.leds(leds));

	// Generate clock
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin

	// Test 1 - test reading and writing to memory to 2 addresses
		cs_pin=0;
		//address one: 1101101
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500 //r-w is low for write
		sclk_pin=1; #500
		//inputting data 10101010
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		cs_pin=1; #5000


		cs_pin=0;
		//address two: 0001010
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500 //r-w is low for write
		sclk_pin=1; #500
		//inputting data 01010101
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		cs_pin=1; #5000

		//read from address one
		cs_pin=0;
		//address one: 1101101
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500 //r-w is high for read
		sclk_pin=1; #500
		//we should geet 10101010 back
		sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 1A failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 1B failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 1C failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 1D failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 1E failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 1F failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 1G failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 1H failed: ", miso_pin);
		sclk_pin=1; #500
		cs_pin=1; #5000


		//read from address two
		cs_pin=0;
		//address two: 0001010
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500 //r-w is high for read
		sclk_pin=1; #500
		//we should geet 01010101 back
		sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 1I failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 1J failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 1K failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 1L failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 1M failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 1N failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 1O failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 1P failed: ", miso_pin);
		sclk_pin=1; #500 
		cs_pin=1; #5000

		// Test 3 - test chip select features
		// We are going to keep chip select high for the write and hope that it does work

		//writing to address 1 
		cs_pin=1;
		//address one: 1101101
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500 //r-w is low for write
		sclk_pin=1; #500
		//inputting data 01010101
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		cs_pin=1; #5000

		//reading from address 1 - it shouldn't have changed
		//read from address one
		cs_pin=0;
		//address one: 1101101
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=0; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500
		sclk_pin=1; #500
		sclk_pin=0;mosi_pin=1; #500 //r-w is high for read
		sclk_pin=1; #500
		//we should geet 10101010 back
		sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 2A failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 2B failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 2C failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 2D failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 2E failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 2F failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 1) $display("Oh no test 2G failed: ", miso_pin);
		sclk_pin=1; #500 sclk_pin=0; #500
		if(miso_pin !== 0) $display("Oh no test 2H failed: ", miso_pin);
		sclk_pin=1; #500
		cs_pin=1; #5000

		$display("testing done");
	end

endmodule // test_spimemory