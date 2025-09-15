module Bit_select #(parameter bit_num = 10,parameter num_width = 3)(
  input en,clk,rst,arst_n,
  output reg[num_width:0] bit_index,
  output reg busy,done
);

always @(posedge clk or negedge arst_n) begin
  if (~arst_n) begin
    bit_index <= 0;
    busy <= 0;
    done <= 1;
  end
  else if (rst) begin
    bit_index <= 0;
    busy <= 0;
    done <= 1;
  end
  else if (en) begin
    if (bit_index == bit_num-1) begin
      busy <= 0;
      done <= 1;
      bit_index <= {(num_width+1){1'b0}};
    end
    else begin
      busy <= 1;
      done <= 0;
      bit_index <= bit_index + 1;
    end
  end
end
endmodule
