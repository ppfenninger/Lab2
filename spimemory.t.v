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
	
endmodule // test_spimemory