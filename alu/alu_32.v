module alu_32(
    output [31:0] result,
    output [31:0] extra,
    output done,
    input [31:0] op1,
    input [31:0] op2,
    input [1:0] control,
    input enable,
    input reset,
    input clock
);

    // State registers
    reg [1:0] last_control;

    // Operand registers
    reg [31:0] a;
    reg [31:0] b;
    reg carry_in;

    // Control registers
    reg ripple_reset;
    reg multiply_enable;
    reg divide_enable;


    // Result registers

    // Adder
    wire [31:0] sum;
    wire carry_out;

    // Product
    wire [63:0] product;
    wire multiply_done;

    // Quotient
    wire [31:0] quotient;
    wire [31:0] remainder;
    wire divide_done;

    // Modules

    // Multiplexers

    mux_4 result_mux(
        .data_out(result),
        .data_0(sum),
        .data_1(sum),
        .data_2(product[31:0]),
        .data_3(quotient),
        .select(last_control)
    );

    mux_4 extra_mux(
        .data_out(extra),
        .data_0({31'b0, carry_out}),
        .data_1({31'b0, carry_out}),
        .data_2(product[63:32]),
        .data_3(remainder),
        .select(last_control)
    );

    mux_4 #(.width(1)) done_mux(
        .data_out(done),
        .data_0(1'b1),
        .data_1(1'b1),
        .data_2(multiply_done),
        .data_3(divide_done),
        .select(last_control)
    );

    // Arithmetic

    adder_32 adder(
        .s(sum),
        .c_out(carry_out),
        .a(a),
        .b(b),
        .c_in(carry_in)
    );

    multiplier_32 multiplier(
        .p(product),
        .dne(multiply_done),
        .a(a),
        .b(b),
        .clk(clock),
        .rst(ripple_reset),
        .ena(multiply_enable)
    );

    divider_32 divider(
        .q(quotient),
        .r(remainder),
        .dne(divide_done),
        .a(a),
        .b(b),
        .clk(clock),
        .rst(ripple_reset),
        .ena(divide_enable)
    );

    initial begin
        last_control = 0;
        a = 0;
        b = 0;
        carry_in = 0;
    end

    always @(posedge reset) begin
        if (enable) begin
            // On reset, update operation

            // Update internal control
            last_control <= control;

            case (control)
                // Add operation
                0: begin
                    a <= op1;
                    b <= op2;
                    carry_in <= 0;

                    multiply_enable <= 0;
                    divide_enable <= 0;
                end

                // Subtract operation
                1: begin
                    a <= op1;
                    b <= ~op2;
                    carry_in <= 1;

                    multiply_enable <= 0;
                    divide_enable <= 0;
                end

                // Multiply operation
                2: begin
                    a = op1;
                    b = op2;
                    
                    multiply_enable <= 1;
                    divide_enable <= 0;
                end

                // Divide operation
                3: begin
                    a = op1;
                    b = op2;
                    
                    multiply_enable <= 0;
                    divide_enable <= 1;
                end
            endcase

            ripple_reset = 1;
        end
    end

    always @(negedge reset) begin
        ripple_reset = 0;
    end

endmodule
