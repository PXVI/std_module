/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 22:01:02 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : XOR gate tectbench
 * ----------------------------------------------------------------------------------- */

`include "xor_gate.v"

module xor_gate_top;

    reg I0, I1;
    wire Out;

    xor_gate gate0( I0, I1, Out );

    initial
    begin
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
        I0 = 0;
        I1 = 0;
        #1;
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
        I0 = 0;
        I1 = 1;
        #1;
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
        I0 = 1;
        I1 = 0;
        #1;
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
        I0 = 1;
        I1 = 1;
        #1;
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
    end
    
endmodule

