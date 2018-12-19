module mux_2 #(
        parameter width = 32
    )
    (
        output reg [(width-1):0] data_out,
        input [(width-1):0] data_0,
        input [(width-1):0] data_1,
        input select
    );

    always @(*) begin
        case (select)
            0: data_out <= data_0;
            1: data_out <= data_1;
        endcase
    end

endmodule