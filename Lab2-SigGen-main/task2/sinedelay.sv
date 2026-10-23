module sigdelay #(
    parameter A_WIDTH = 9,
    parameter D_WIDTH = 8
)(
    input  logic               clk,
    input  logic               rst,
    input  logic               en,
    input  logic [D_WIDTH-1:0] mic_signal,
    input  logic [A_WIDTH-1:0] offset,
    output logic [D_WIDTH-1:0] delayed_signal
);

logic [A_WIDTH-1:0] wr_addr;
logic [A_WIDTH-1:0] rd_addr;

counter #(
    .WIDTH(A_WIDTH)
) addrCounter (
    .clk(clk),
    .rst(rst),
    .en(en),
    .incr(9'd1),
    .count(wr_addr)
);

assign rd_addr = wr_addr - offset;

ram #(
    .ADDRESS_WIDTH(A_WIDTH),
    .DATA_WIDTH(D_WIDTH)
) audioRam (
    .clk(clk),
    .we(en),
    .wr_addr(wr_addr),
    .rd_addr(rd_addr),
    .wr_data(mic_signal),
    .rd_data(delayed_signal)
);

endmodule