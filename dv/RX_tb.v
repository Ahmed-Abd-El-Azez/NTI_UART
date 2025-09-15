module RX_tb ();

reg RX,rx_en,clk,rst,arst_n;
wire done_rx,err,busy;
wire [7:0]data_rx;
reg[9:0] tx_word;

UART_RX uart_rx(
  .RX(RX),
  .rx_en(rx_en),
  .clk(clk),
  .rst(rst),
  .arst_n(arst_n),
  .done(done_rx),
  .err(err),
  .busy(busy),
  .data(data_rx)
  );

initial begin
  clk = 0;
  forever begin
    #5 clk = ~clk;
  end
end

integer i;

initial begin
  testing(8'b01010101);
  testing(8'b10101010);
  testing(8'b11111111);
  testing(8'b00000000);
  testing(8'b11110000);
  testing(8'b00001111);
  testing(8'b10110100);
  testing(8'b01101101);
  $stop;
end

task testing(input [7:0] data_in);begin
  RX = 1;
  tx_word = {1'b1,data_in,1'b0};
  rst = 1;
  arst_n = 0;
  rx_en = 0;
  RX = 1;
  #10
  rst = 0;
  arst_n = 1;
  rx_en = 1;
  #50
  for (i = 0 ; i < 10;i = i+1 ) begin
    #104170
    RX = tx_word[i];
  end
  #104170
  if (data_in!=data_rx) begin
    $display("Error detected!");
    $stop;
  end
  else
    $display("Test based!");

  #104170;
end
endtask
endmodule