/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 21:56:57 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : Collective testbench for all the Multiplexer modules. This
 *                is to be used just as a simple reference
 * ----------------------------------------------------------------------------------- */

`include "mux_2x1.v"

module mux_2x1_top;

    reg [3:0] I0, I1;
    reg SEL;
    wire [3:0] Out;
    integer i = 0;

    mux_2x1 mux0( I0, I1, SEL, Out );

    initial
    begin

        for( i = 0; i < 16; i = i + 1 )
        begin
            SEL = i[0];
            I0 = i+1;
            I1 = i+2;
            #1;
            $display( "I0 = %0d, I1 = %0d, SEL = %0d, Out = %0d", I0, I1, SEL, Out );
        end
    end
    
endmodule
