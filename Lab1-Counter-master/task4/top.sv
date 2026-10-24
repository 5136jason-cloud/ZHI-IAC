module top #(
    parameter WIDTH = 8
)(
    input  logic             clk,
    input  logic             rst,
    input  logic             en,
    input  logic [WIDTH-1:0] v,
    output logic [11:0]      bcd
);

logic [WIDTH-1:0] count;

counter myCounter (
    .clk   (clk),
    .rst   (rst),
    .en    (en),
    .count (count)
);

bin2bcd myDecoder (
    .x   (count),
    .BCD (bcd)
);

endmodule