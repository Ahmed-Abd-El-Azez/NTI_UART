module FSM (
  input rx_en,tick,stop_bit,en,clk,rst,arst_n,
  output load,busy,done,err,en_out
);

localparam [2:0]IDEL = 0;
localparam [2:0]START = 1;
localparam [2:0]DATA = 2;
localparam [2:0]STOP = 3;
localparam [2:0]ERROR = 4;
localparam [2:0]DONE = 5;

reg[2:0] cs,ns;
reg[3:0]count;

always @(*) begin
  if (~rx_en) begin
    ns = IDEL;
  end
  else begin
    case (cs)
      IDEL:
        if (tick) begin
          ns = START;
        end
        else
          ns = IDEL;
      START:
        if (en) begin
          ns = DATA;
        end
      DATA:
        if (en) begin
          if (count == 8)
            ns = STOP;
          else
            ns = DATA;
        end
      STOP:
        if (stop_bit) begin
          ns = DONE;
        end
        else
          ns = ERROR;
      ERROR:
        ns = ERROR;
      DONE:
        ns = DONE;
      default:
        ns = IDEL;
    endcase
  end
end

always @(posedge clk or negedge arst_n) begin
  if (~arst_n) begin
    cs <= IDEL;
    count <= 0;
  end
  else if (rst) begin
    cs <= IDEL;
    count <= 0;
  end
  else begin
    cs <= ns;
    if ((cs == START) && en)
      count <= 0;
    else if ((cs == DATA) && en)
      count <= count + 1;
  end
end

assign en_out = ((cs==DATA) && en && (count<8))?1:0;
assign load =(cs==START)?0:1;
assign busy = ((cs== START)|| (cs==DATA))?1:0;
assign done = (cs== DONE)?1:0;
assign err = (cs == ERROR)?1:0;

endmodule //FSM
