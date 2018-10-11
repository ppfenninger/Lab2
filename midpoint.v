`include "shiftregister.v"
`include "inputconditioner.v"

module midpoint(
	input clk,
	input  sw0,
	input  sw1,
	input  btn,
	output [3:0] led);

	wire parallel_load;
	wire serial_in;
	wire clk_edge;

	inputconditioner button_conditioner(
		.clk(clk),
		.noisysignal(btn),
		.conditioned(),
		.positiveedge(),
		.negativeedge(parallel_load));

	inputconditioner switch_0_conditioner(
		.clk(clk),
		.noisysignal(sw0),
		.conditioned(serial_in),
		.positiveedge(),
		.negativeedge());

	inputconditioner switch_1_conditioner(
		.clk(clk),
		.noisysignal(sw1),
		.conditioned(),
		.positiveedge(clk_edge),
		.negativeedge());

	shiftregister #(4) shift_register(
		.clk(clk),
		.peripheralClkEdge(clk_edge),
		.parallelLoad(parallel_load),
		.parallelDataIn(4'b1101),
		.serialDataIn(serial_in),
		.parallelDataOut(led),
		.serialDataOut());
endmodule