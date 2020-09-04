/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 00:37:22 IST, 05 September, 2020 [ Saturday ]
 *
 * Author       : pxvi
 * Description  : Basic testbench for decoder
 * ----------------------------------------------------------------------------------- */

`include "decoder_Nx2pN.v"

module decoder_Nx2pN_top;

    reg [2:0] IN;
    wire [(2**3)-1:0] OUT;
    integer i = 0;

    decoder_Nx2pN#( .N( 3 ) ) decoder( IN, OUT );

    initial
    begin
        for( i = 0; i <= 2**3; i = i + 1 )
        begin
            $display( "IN = %0d, OUT = %b", IN, OUT );
            IN = i;
            #1;
        end
    end

endmodule
