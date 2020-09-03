/* -----------------------------------------------------------------------------------
 * Module Name  : mux_2x1
 * Date Created : 21:08:47 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : Basic input parmetrized 2 to 1 multiplexer
 * ----------------------------------------------------------------------------------- */

module mux_2x1#( parameter WIDTH = 4 )(     input [WIDTH-1:0] IN0,
                                            input [WIDTH-1:0] IN1,
                                            input SEL,
                                            output [WIDTH-1:0] OUT0 );

    reg [WIDTH-1:0] OUT0_r;

    always@( * )
    begin
        if( !SEL )
        begin
            OUT0_r = IN0;
        end
        else if( SEL )
        begin
            OUT0_r = IN1;
        end
    end

    assign OUT0 = OUT0_r;

endmodule
