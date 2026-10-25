module sinegen #(
    parameter A_WIDTH = 8,
              D_WIDTH = 8
)(
    input  logic                 clk,
    input  logic                 rst,
    input  logic                 en,
    input  logic [A_WIDTH-1:0]   offset,
    output logic [D_WIDTH-1:0]   data1,
    output logic [D_WIDTH-1:0]   data2
);

logic [A_WIDTH-1:0] address1;
logic [A_WIDTH-1:0] address2;

counter #(
    .WIDTH(A_WIDTH)
) addrCounter (
    .clk   (clk),
    .rst   (rst),
    .en    (en),
    .incr  ({{A_WIDTH-3{1'b0}}, {3{1'b1}}}),
    .count (address1)
);

assign address2 = address1 + offset;
rom #(
    .ADDRESS_WIDTH(A_WIDTH),
    .DATA_WIDTH(D_WIDTH)
) sineRom (
    .clk   (clk),
    .addr1 (address1),
    .addr2 (address2),
    .data1 (data1),
    .data2 (data2)
);

endmodule
