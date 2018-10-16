module fsm(
	input clk,
	input sclk,
	input nCS,
	input RnW,
	output reg MISO_buff,
	output reg memory_we,
	output reg address_we,
	output reg sr_we
	);

	reg [3:0] state;
	integer counter = 0;
	localparam STATE_wait_for_cs    = 0;
	localparam STATE_read_addr      = 1;
	localparam STATE_load_addr      = 2;
	localparam STATE_read_data      = 3;
	localparam STATE_store_data     = 4;
	localparam STATE_load_data      = 5;
	localparam STATE_shift_out_data = 6;
	localparam STATE_data_stored    = 7;

	always @(posedge clk) begin
		//If CS goes high, reset
		if(nCS) begin
			state <= STATE_wait_for_cs;
			counter <= 0;
		end

		else begin
			case (state)

				STATE_wait_for_cs: begin
					if (!nCS)
						state <= STATE_read_addr;
					else
						state <= STATE_wait_for_cs;
				end // STATE_wait_for_cs

				STATE_read_addr: begin
					if (counter == 8)
						state <= STATE_load_addr;
					else
						state <= STATE_read_addr;
				end // STATE_read_addr:

				STATE_load_addr: begin
					if (RnW)
						state <= STATE_load_data;
					else
						state <= STATE_read_data;
				end // STATE_load_addr:

				STATE_read_data: begin
					if (counter == 16)
						state <= STATE_store_data;
					else
						state <= STATE_read_data;
				end // STATE_read_data:

				STATE_store_data:
					state <= STATE_data_stored;

				STATE_load_data:
					state <= STATE_shift_out_data;

				STATE_shift_out_data: begin
					if (nCS == 0)
						state <= STATE_shift_out_data;
					else
						state <= STATE_wait_for_cs;
				end

				STATE_data_stored: begin
					if (nCS == 0)
						state <= STATE_data_stored;
					else
						state <= STATE_wait_for_cs;
				end
			endcase
		end // else
	end // always @(posedge clk)

	always @(state) begin
		case (state)
			STATE_wait_for_cs: begin
				MISO_buff  = 0;
				memory_we  = 0;
				address_we = 0;
				sr_we      = 0;
			end // STATE_wait_for_cs

			STATE_read_addr: begin
				MISO_buff  = 0;
				memory_we  = 0;
				address_we = 0;
				sr_we      = 0;
			end // STATE_read_addr:

			STATE_load_addr: begin
				MISO_buff  = 0;
				memory_we  = 0;
				address_we = 1;
				sr_we      = 0;
			end // STATE_load_addr:

			STATE_read_data: begin
				MISO_buff  = 0;
				memory_we  = 0;
				address_we = 0;
				sr_we      = 0;
			end // STATE_read_data:

			STATE_store_data: begin
				MISO_buff  = 0;
				memory_we  = 1;
				address_we = 0;
				sr_we      = 0;
			end

			STATE_load_data: begin
				MISO_buff  = 0;
				memory_we  = 0;
				address_we = 0;
				sr_we      = 1;
			end

			STATE_shift_out_data: begin
				MISO_buff  = 1;
				memory_we  = 0;
				address_we = 0;
				sr_we      = 0;
			end

			STATE_data_stored: begin
				MISO_buff  = 0;
				memory_we  = 0;
				address_we = 0;
				sr_we      = 0;
			end
		endcase
	end // always @(state)

	always @(posedge sclk) begin
		if(nCS == 0)
			counter <= counter + 1;
	end
endmodule