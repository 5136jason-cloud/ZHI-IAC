module ram #(
    parameter ADDRESS_WIDTH = 9,
    parameter DATA_WIDTH = 8
)(
    input  logic                     clk,
    input  logic                     wr,
    input  logic                     rd,
    input  logic [ADDRESS_WIDTH-1:0] wr_addr,
    input  logic [ADDRESS_WIDTH-1:0] rd_addr,
    input  logic [DATA_WIDTH-1:0]    wr_data,
    output logic [DATA_WIDTH-1:0]    rd_data
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

always_ff @(posedge clk) begin
    if (wr)
        ram_array[wr_addr] <= wr_data;

    if (rd)
        rd_data <= ram_array[rd_addr];
end

endmodule
