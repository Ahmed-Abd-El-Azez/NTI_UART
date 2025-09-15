module Edge_detector (
  input wire cs,clk,rst,arst_n,
  output reg tick
);

  reg prev;

  always @(posedge clk or negedge arst_n) begin
    if (~arst_n) begin
      prev <= 1'b1;
      tick <= 1'b0;
    end
    else if(rst) begin
      prev <= 1'b1;
      tick <= 1'b0;
    end
    else begin
      tick <= prev & ~cs;
      prev <= cs;
    end
  end

endmodule
