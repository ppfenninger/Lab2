module dff_buffer
(
	input q,
	input write_enable,
	input miso_enable,
	input clk,
	output reg d
);

	reg memory;

	always @(posedge clk) begin
		if (miso_enable) begin
			if (write_enable)
				memory <= q;
			d <= memory;
		end // if (miso_enable)
		else
			d <= 1'bz;
	end // always @(posedge clk)

endmodule