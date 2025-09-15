module UART (
input RX,clk,rst,arst_n,rx_en,tx_en,
input[7:0] data_in,
output[7:0] data_out,
output TX,err,done_rx,busy_rx,done_tx,busy_tx
);

UART_RX uart_rx(
  .RX(RX),
  .clk(clk),
  .rst(rst),
  .arst_n(arst_n),
  .rx_en(rx_en),
  .err(err),
  .done(done_rx),
  .busy(busy_rx),
  .data(data_out)
  );

UART_TX uart_tx(
  .clk(clk),
  .rst(rst),
  .arst_n(arst_n),
  .tx_en(tx_en),
  .tx(TX),
  .done(done_tx),
  .busy(busy_tx),
  .data(data_out)
  );

endmodule //UART