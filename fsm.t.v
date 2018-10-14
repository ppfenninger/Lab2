`include "fsm.v"
module test_fsm();

	reg clk;
	reg sclk;
	reg nCS;
	reg RnW;
	wire MISO_buff;
	wire memory_we;
	wire address_we;
	wire sr_we;

	fsm dut(
		.clk(clk),
		.sclk(sclk),
		.nCS(nCS),
		.RnW(RnW),
		.MISO_buff(MISO_buff),
		.memory_we(memory_we),
		.address_we(address_we),
		.sr_we(sr_we)
	);

	initial begin
		$dumpfile("fsm.vcd");
		$dumpvars();

		clk = 0;
		sclk = 0;
		nCS = 1;
		RnW = 0;

		repeat(10) begin
			#1 clk = clk - 1;
		end
		
		nCS = 0;
		sclk = 0;

		repeat(32) begin
			repeat(10) begin
				#1 clk = clk - 1;
			end

			sclk = sclk - 1;
		end

		repeat(10) begin
			#1 clk = clk - 1;
		end

		nCS = 1;

		repeat(10) begin
			#1 clk = clk - 1;
		end

		RnW = 1;

		repeat(10) begin
			#1 clk = clk - 1;
		end
		
		nCS = 0;
		sclk = 0;

		repeat(32) begin
			repeat(10) begin
				#1 clk = clk - 1;
			end

			sclk = sclk - 1;
		end

		repeat(10) begin
			#1 clk = clk - 1;
		end

		nCS = 1;

		repeat(10) begin
			#1 clk = clk - 1;
		end
	end

endmodule