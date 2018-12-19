module sign_extend #(
    parameter output_width = 32,
    parameter input_width = 16
)(
    output [(output_width - 1):0] data_out,
    input [(input_width - 1):0] data_in
);

    assign data_out[(input_width - 1):0] = data_in;
    assign data_out[(output_width - 1):input_width] =
        {(output_width - input_width){data_in[(input_width - 1)]}};

endmodule
