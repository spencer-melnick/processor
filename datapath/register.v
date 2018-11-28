module register #(
    parameter word_length = 32,
    parameter num_registers = 32
) (
    output reg [(word_length - 1):0] data1_out,
    output reg [(word_length - 1):0] data2_out,
    input [4:0] read1_address,
    input [4:0] read2_address,
    input write_enable,
    input [4:0] write_address,
    input [(word_length - 1):0] data_in
);

    reg [(word_length - 1):0] data[(num_registers - 1):0];
    integer i;

    initial begin
        $readmemh("../misc/registers.txt", data);
    end

    always @(*) begin
        data1_out = data[read1_address];
        data2_out = data[read2_address];
    end

    always @(posedge write_enable) begin
        data[write_address] = data_in;
    end

endmodule
