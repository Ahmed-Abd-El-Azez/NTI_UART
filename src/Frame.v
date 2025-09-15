module Frame #(parameter data_width = 8)(
  input[data_width-1:0] data_in,
  input enable,
  output[data_width+1:0] frame_data
);

assign frame_data = enable ? {1'b1, data_in, 1'b0} : {(data_width+2){1'b1}};

endmodule
