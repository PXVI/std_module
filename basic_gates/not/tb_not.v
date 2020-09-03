/* -----------------------------------------------------------------------------------
 * Module Name  : - 
 * Date Created : 22:10:07 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : NOT gate testbench
 * ----------------------------------------------------------------------------------- */

`include "not_gate.v"

module not_gate_top;

    reg I0;
    wire Out;

    not_gate gate0( I0, Out );

    initial
    begin
        $display( "I0 : %b, Out : %b", I0, Out );
        I0 = 0;
        #1;
        $display( "I0 : %b, Out : %b", I0, Out );
        I0 = 1;
        #1;
        $display( "I0 : %b, Out : %b", I0, Out );
    end
    
endmodule
