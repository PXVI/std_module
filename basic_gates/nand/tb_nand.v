/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 22:09:53 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : NAND gate testbench
 * ----------------------------------------------------------------------------------- */

`include "nand_gate.v"

module nand_gate_top;

    reg I0, I1;
    wire Out;

    nand_gate gate0( I0, I1, Out );

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

