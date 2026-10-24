module counter #(
    parameter WIDTH = 8
)(
    input  logic             clk,
    input  logic             rst,
    input  logic             en,
    output logic [WIDTH-1:0] count
);

always_ff @(posedge clk) begin
    if (rst)
        count <= {WIDTH{1'b0}};
    else if (en)
        count <= count + 1'b1;
    else
        count <= count - 1'b1;
end

endmodule

