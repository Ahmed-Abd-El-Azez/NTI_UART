module UART_RX (
input RX,rx_en,clk,rst,arst_n,
output done,err,busy,
output [7:0] data
);

wire baud_load,sample_en,tick,baud_en;

Edge_detector edge_detector(
  .clk(clk),
  .rst(rst),
  .arst_n(arst_n),
  .cs(RX),
  .tick(tick)
  );
FSM fsm(
  .clk(clk),
  .rst(rst),
  .arst_n(arst_n),
  .done(done),
  .err(err),
  .busy(busy),
  .tick(tick),
  .stop_bit(RX),
  .rx_en(rx_en),
  .en(baud_en),
  .load(baud_load)
  ,.en_out(sample_en)
  );
SIPO_shift_reg sipo(
  .clk(clk),
  .rst(rst),
  .arst_n(arst_n),
  .serial_in(RX),
  .data(data),
  .en(sample_en)
  );
Baud_counter baud_counter(
  .clk(clk),
  .rst(rst),
  .arst_n(arst_n),
  .load(baud_load),
  .en(baud_en)
  );


endmodule
