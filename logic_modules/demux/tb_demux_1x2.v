/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 22:23:45 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : Testbench for the basic 1x2 de-multiplexer
 * ----------------------------------------------------------------------------------- */

`include "demux_1x2.v"

module demux_1x2_top;
    
    reg [3:0] in0;
    reg sel;
    wire [3:0] out0, out1;

    integer i = 0;

    demux_1x2 demux( in0, sel, out0, out1 );

    initial
    begin
        for( i = 0; i < 16; i = i + 1 )
        begin
            in0 = i+1;
            sel = i[0];
            #1;
            $display( "in0 = %0d, sel = %0d, out0 = %0d, out1 = %0d", in0, sel, out0, out1 );
        end
    end

endmodule
