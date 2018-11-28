module left_shift #(
    parameter width = 32,
    parameter shift_amount = 2
) (
    output [(width - 1):0] data_out,
    input [(width - 1):0] data_in
);

    assign data_out[(width - 1):(shift_amount)] = data_in[(width - (1 + shift_amount)):0];
    assign data_out[(shift_amount - 1):0] = 0;

endmodule
