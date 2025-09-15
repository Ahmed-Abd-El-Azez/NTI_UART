module TX_tb ();

reg tx_en,rst,arst_n,clk;
reg[7:0] data;
reg [9:0] exp_tx,tx_word;
wire done,busy,tx;

UART_TX uart_tx(.tx_en(tx_en),.rst(rst),.arst_n(arst_n),.clk(clk),.data(data),.done(done),.busy(busy),.tx(tx));

initial begin
  clk = 0;
  forever begin
    #5 clk = ~clk;
  end
end

integer i;

initial begin
  testing(8'b11110000);
  testing(8'b11110001);
  testing(8'b11110011);
  testing(8'b11111111);
  testing(8'b00000000);
  testing(8'b10010001);
  testing(8'b11000001);
  testing(8'b01110100);
  testing(8'b01110010);
  $stop;
end

task testing(input [7:0]data_in);begin
  rst = 1;
  arst_n = 0;
  tx_en = 0;
  #10
  tx_word = {10{1'b0}};
  rst = 0;
  arst_n = 1;
  #10
  data = data_in;
  exp_tx = {1'b1,data_in,1'b0};
  tx_en = 1;
  for (i = 0 ; i < 10;i = i+1 ) begin
    #104170
    tx_word[i] = tx;
  end
  if (exp_tx != tx_word) begin
      $display("Error!");
      $stop;
    end
    else
      $display("based!");
  #104170;
end
endtask
endmodule //TX_tb
