// Write your modules here!
module adder #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire [WIDTH-1:0] sum
);

  assign sum = a + b;
endmodule

module subtractor #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire [WIDTH-1:0] diff
);

  assign diff = a - b;
endmodule

module bitwise_and #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire [WIDTH-1:0] b_and
);

  assign b_and = a & b;
endmodule

module bitwise_or #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire [WIDTH-1:0] b_or
);

  assign b_or = a & b;
endmodule

module bitwise_xor #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire [WIDTH-1:0] b_xor
);

  assign b_xor = a ^ b;
endmodule

module is_equal #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire a_equal
);

  assign a_equal = (a == b);
endmodule

module is_greater #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire a_greater
);

  assign a_greater = (a > b);
endmodule

module is_lower #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire a_less
);

  assign a_less = (a < b);
endmodule

module left_shift #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a,
  input wire [WIDTH/2-1:0] shift,
  output wire [WIDTH-1:0] left_shift
);
  assign left_shift = (a << shift);
endmodule

module right_shift #(parameter WIDTH = 8)(
  input wire [WIDTH-1:0] a,
  input wire [WIDTH/2-1:0] shift,
  output wire [WIDTH-1:0] right_shift
);
  assign right_shift = a >> shift;
endmodule

module multiplicator #(parameter WIDTH = 8) (
  input wire [WIDTH-1:0] a, b,
  output wire [WIDTH*2-1:0] multiplication
);

  assign multiplication = a * b;
endmodule


module alu #(parameter IN_WIDTH = 8, parameter OPCODE_WIDTH = 4) (
    input wire [IN_WIDTH-1:0] a, b,
    input wire [OPCODE_WIDTH-1:0] opcode,
    output wire [IN_WIDTH*2-1:0] result
);
    parameter OUT_WIDTH = IN_WIDTH*2;

    wire [OUT_WIDTH-1:0] result_add;
    wire [OUT_WIDTH-1:0] result_sub;
    wire [OUT_WIDTH-1:0] result_and;
    wire [OUT_WIDTH-1:0] result_or;
    wire [OUT_WIDTH-1:0] result_xor;
    wire [OUT_WIDTH-1:0] result_l_shift;
    wire [OUT_WIDTH-1:0] result_r_shift;
    wire [OUT_WIDTH-1:0] result_mul;

    adder #(IN_WIDTH) u_adder (a, b, result_add);
    subtractor #(IN_WIDTH) u_subtractor (a, b, result_sub);
    bitwise_and #(IN_WIDTH) u_bitwise_and(a, b, result_and);
    bitwise_or #(IN_WIDTH) u_bitwise_or(a, b, result_or);
    bitwise_xor #(IN_WIDTH) u_bitwise_xor(a, b, result_xor);
    left_shift #(IN_WIDTH) u_left_shift (.a(a), .shift(b), .left_shift(result_l_shift));
    right_shift #(IN_WIDTH) u_right_shift (.a(a), .shift(b), .right_shift(result_r_shift));
    multiplicator #(IN_WIDTH) u_multiplicator (.a(a), .b(b), .multiplication(result_mul));

    assign result = (opcode == 4'b0000) ? result_add :
                    (opcode == 4'b0001) ? result_sub :
                    (opcode == 4'b0010) ? result_and :
                    (opcode == 4'b0011) ? result_or :
                    (opcode == 4'b0100) ? result_xor :
                    (opcode == 4'b0101) ? result_l_shift :
                    (opcode == 4'b0110) ? result_r_shift :
                    (opcode == 4'b0111) ? result_mul :
                    {OUT_WIDTH{1'b0}};
endmodule
