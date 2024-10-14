module tb_alu;

    parameter WIDTH = 4;
    parameter N = 20;

    reg [WIDTH-1:0] a, b;
 	reg [2:0] opcode;
    wire [(WIDTH*2)-1:0] result;

    alu #(.IN_WIDTH(WIDTH)) dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        repeat (N) begin
            a = $urandom;
            b = $urandom;
            opcode = $urandom;
            #10;
            $display("A: %d    B: %d    Opcode: %d     Result: %d", a, b, opcode, result);
        end
        // End simulation
        $display("TEST FINISHED!!!");
        $finish;
    end

endmodule

