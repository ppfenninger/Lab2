//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------
`include "inputconditioner.v"
`include "datamemory.v"
`include "shiftregister.v"
`include "fsm.v"
`include "register8.v"
`include "dff_buffer.v"

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output reg  		led       // LEDs for debugging
);
	
	wire mosi_conditioned;
	wire sclk_posedge;
	wire sclk_negedge;
	wire cs_conditioned;
	wire sr_we;
	wire[7:0] data_memory_out;
	wire[7:0] shift_register_parallel_out;
	wire shift_register_serial_out;
	wire address_we;
	wire[7:0] address_latch_out;
	wire MISO_buff;
	wire memory_we;

	always @(posedge clk) led <= cs_pin;

	inputconditioner mosi_conditioner(
		.clk(clk),
		.noisysignal(mosi_pin),
		.conditioned(mosi_conditioned),
		.positiveedge(),
		.negativeedge());

	inputconditioner sclk_conditioner(
		.clk(clk),
		.noisysignal(sclk_pin),
		.conditioned(),
		.positiveedge(sclk_posedge),
		.negativeedge(sclk_negedge));

	inputconditioner cs_conditioner(
		.clk(clk),
		.noisysignal(cs_pin),
		.conditioned(cs_conditioned),
		.positiveedge(),
		.negativeedge());

	shiftregister #(8) shift_register(
		.clk(clk),
		.peripheralClkEdge(sclk_posedge),
		.parallelLoad(sr_we),
		.parallelDataIn(data_memory_out),
		.serialDataIn(mosi_conditioned),
		.parallelDataOut(shift_register_parallel_out),
		.serialDataOut(shift_register_serial_out));

	register8 address_latch(
		.clk(clk),
		.wrenable(address_we),
		.d(shift_register_parallel_out),
		.q(address_latch_out));

	dff_buffer miso_buffer(
		.clk(clk),
		.q(shift_register_serial_out),
		.miso_enable(MISO_buff),
		.write_enable(sclk_negedge),
		.d(miso_pin));

	fsm spi_fsm(
		.clk(clk),
		.sclk(sclk_posedge),
		.nCS(cs_conditioned),
		.RnW(shift_register_parallel_out[0]),
		.MISO_buff(MISO_buff),
		.memory_we(memory_we),
		.address_we(address_we),
		.sr_we(sr_we));

	datamemory spi_mem(
		.clk(clk),
		.address(address_latch_out[7:1]),
		.writeEnable(memory_we),
		.dataIn(shift_register_parallel_out),
		.dataOut(data_memory_out));


endmodule
   
