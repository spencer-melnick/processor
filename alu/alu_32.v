module alu_32(
    output reg [31:0] result,
    output reg [31:0] extra,
    output reg done,
    input [31:0] op1,
    input [31:0] op2,
    input [2:0] control,
    input enable,
    input reset,
    input clock
);

    // State registers
    reg [2:0] last_control;

    // Operand registers
    reg [31:0] a;
    reg [31:0] b;

    // Control registers
    reg multiply_enable;
    reg divide_enable;


    // Result registers

    // Adder
    reg [31:0] sum;
    reg carry_out;

    // Product
    reg [63:0] product;
    reg multiply_done;

    // Quotient
    reg [31:0] quotient;
    reg [31:0] remainder;
    reg divide_done;

    adder_32 adder(
        .s(sum),
        .c_out(carry_out),
        .a(a),
        .b(b)
    );

    multiplier_32 multiplier(
        .p(product),
        .dne(multiply_done),
        .a(a),
        .b(b),
        .clk(clock),
        .rst(reset)
    );

    divider_32 divider(
        .q(quotient),
        .r(remainder),
        .dne(divide_done),
        .a(a),
        .b(b),
        .clk(clock),
        .rst(reset),
        .ena(divide_enable)
    );

    initial begin
        last_control = 0;
        a = 0;
        b = 0;
    end

    always @(posedge clock) begin
        if (enable) begin
            if (reset) begin
                // On reset, update operation

                // Update internal control
                last_control <= control;
                a <= op1;
                b <= op2;

                case (control)
                    // Add operation
                    1: begin
                        result <= sum;
                        extra <= carry_out
                        done <= 1;
                    end

                    // Subtract operation
                    2: begin
                        
                    end
                endcase
        end
    end

endmodule
