module mux_4 #(
        parameter width = 32
    )
    (
        output reg [(width-1):0] data_out,
        input [(width-1):0] data_0,
        input [(width-1):0] data_1,
        input [(width-1):0] data_2,
        input [(width-1):0] data_3,
        input [1:0] select
    );

    always @(*) begin
        case (select)
            0: data_out <= data_0;
            1: data_out <= data_1;
            2: data_out <= data_2;
            3: data_out <= data_3;
        endcase
    end

endmodule