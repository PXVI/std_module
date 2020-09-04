/* -----------------------------------------------------------------------------------
 * Module Name  : decoder_Nx2pN
 * Date Created : 23:56:54 IST, 04 September, 2020 [ Friday ]
 *
 * Author       : pxvi
 * Description  : Basic N to 2**N decoder which is of course, parameterized
 * ----------------------------------------------------------------------------------- */

module decoder_Nx2pN #( parameter N = 2 )   ( 
                                                input [N-1:0] IN,
                                                output reg [(2**N)-1:0] OUT
                                            );

    integer i = 0;

    always@(*)
    begin
        for( i = 0; i < 2**N; i = i + 1 )
        begin
            OUT[i] = 0;
        end

        OUT[IN] = 1'b1;
    end

endmodule
