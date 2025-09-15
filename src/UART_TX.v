module UART_TX #(parameter data_width = 8)(
  input tx_en,rst,arst_n,clk,
  input[data_width-1:0] data,
  output done,busy,tx
);
localparam tx_load = 1;
wire[data_width+1:0] frame_data;
wire en;
wire[3:0] mux_slc;

Baud_counter counter(.rst(rst),.clk(clk),.arst_n(arst_n),.en(en),.load(tx_load));
Frame #(data_width)frame(.data_in(data),.enable(tx_en),.frame_data(frame_data));
Bit_select #(10,3) bit_selector(.en(en),.clk(clk),.rst(rst),.arst_n(arst_n),.bit_index(mux_slc),.busy(busy),.done(done));
MUX #(10,3)mux(.mux_in(frame_data),.mux_slc(mux_slc),.mux_out(tx));

endmodule //UART_TX
