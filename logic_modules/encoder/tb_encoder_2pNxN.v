/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 01:56:10 IST, 05 September, 2020 [ Saturday ]
 *
 * Author       : pxvi
 * Description  : Basic testbench for the encoder for 2**N to N encoder
 * ----------------------------------------------------------------------------------- */

`include "encoder_2pNxN.v"

module encoder_2pNxN_top;

    parameter N = 5;

    reg [(2**N)-1:0] IN;
    wire [N-1:0] OUT;

    integer i = 0;

    encoder_2pNxN #( .N( N ) ) encoder ( IN, OUT );

    initial
    begin
        for( i = 0; i < 2**N; i = i + 1 )
        begin
            IN = 1 << i;
            #1;
            $display( "IN = %b, OUT = %0d", IN, OUT );
        end

        $display( "" );

        for( i = 0; i < 2**N; i = i + 1 )
        begin
            IN = ~( 32'd0 ) << i;
            #1;
            $display( "IN = %b, OUT = %0d", IN, OUT );
        end
    end

endmodule
