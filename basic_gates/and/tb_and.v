/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 22:09:48 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : AND gate testbench
 * ----------------------------------------------------------------------------------- */

`include "and_gate.v"

module and_gate_top;

    reg I0, I1;
    wire Out;

    and_gate gate0( I0, I1, Out );

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
