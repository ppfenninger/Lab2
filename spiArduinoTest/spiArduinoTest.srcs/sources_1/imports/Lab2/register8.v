module register8
(
output reg [7:0] q,
input      [7:0] d,
input       wrenable,
input       clk
);
	always @(posedge clk) begin
		if(wrenable) begin
			q[7:0] <= d[7:0];
		end // if(wrenable)
	end // always @(posedge clk)
endmodule