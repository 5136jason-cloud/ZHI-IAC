module counter #(
    parameter WIDTH = 9
)(
    input  logic                     clk,
    input  logic                     rst,
    input  logic                     en,
    input  logic [WIDTH-1:0]         incr,
    output logic [WIDTH-1:0]         count
);

always_ff @(posedge clk) begin
    if (rst)
        count <= 0;
    else if (en)
        count <= count + incr;
end

endmodule
