module SIPO_shift_reg (
  input serial_in,en,clk,rst,arst_n,
  output reg[7:0] data
);

always @(posedge clk or negedge arst_n) begin
  if (~arst_n) begin
    data <= {8{1'b0}};
  end
  else if(rst) begin
    data <= {8{1'b0}};
  end
  else if (en) begin
    data <= {serial_in,data[7:1]};
  end
end

endmodule //SIPO_shift_reg