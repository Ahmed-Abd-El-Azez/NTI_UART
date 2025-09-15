module Baud_counter (
  input load,rst,clk,arst_n,
  output reg en
);

reg[13:0] count;

always @(posedge clk or negedge arst_n) begin
  if (!arst_n) begin
      count <= load ? 14'd10417 : 14'd5208;
      en <= 1'b0;
    end
    else if (rst) begin
      count <= load ? 14'd10417 : 14'd5208;
      en <= 1'b0;
    end
    else if (count == 0) begin
      en <= 1'b1;
      count <= load ? 14'd10417 : 14'd5208;
    end
    else begin
      en <= 1'b0;
      count <= count - 1;
    end
end
endmodule