/* -----------------------------------------------------------------------------------
 * Module Name  : encoder_2pNxN
 * Date Created : 01:17:07 IST, 05 September, 2020 [ Saturday ]
 *
 * Author       : pxvi
 * Description  : Basic parameterized encoder for 2**N to N encoding
 * ----------------------------------------------------------------------------------- */

module encoder_2pNxN #( parameter N = 2 )   (
                                                input [(2**N)-1:0] IN,
                                                output reg [N-1:0] OUT
                                            );

    integer i = 0;

    always@(*)
    begin
        OUT = 0;

        for( i = (2**N)-1; i >= 0; i = i - 1 )
        begin
            if( IN[i] == 1'b1 )
            begin
                OUT = i;
            end
        end
    end

endmodule
