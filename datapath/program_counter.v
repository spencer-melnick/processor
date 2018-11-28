module program_counter #(
    parameter width = 32
) (
    output reg [(width - 1):0] data_out,
    input write_enable,
    input [(width - 1):0] data_in
);

    initial begin
        data_out = 0;
    end

    always @(posedge write_enable) begin
        data_out = data_in;
    end

endmodule
