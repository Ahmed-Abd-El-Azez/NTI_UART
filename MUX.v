module MUX #(parameter bit_num = 10,parameter slc_num = 3)(
  input[bit_num-1:0] mux_in,
  input[slc_num:0] mux_slc,
  output reg mux_out
);

always @(*) begin
  case(mux_slc)
    4'b0000: mux_out = mux_in[mux_slc];
    4'b0001: mux_out = mux_in[mux_slc];
    4'b0010: mux_out = mux_in[mux_slc];
    4'b0011: mux_out = mux_in[mux_slc];
    4'b0100: mux_out = mux_in[mux_slc];
    4'b0101: mux_out = mux_in[mux_slc];
    4'b0110: mux_out = mux_in[mux_slc];
    4'b0111: mux_out = mux_in[mux_slc];
    4'b1000: mux_out = mux_in[mux_slc];
    4'b1001: mux_out = mux_in[mux_slc];
  endcase
end
endmodule //MUX