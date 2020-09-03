/* -----------------------------------------------------------------------------------
 * Module Name  : demux_1x2
 * Date Created : 21:52:23 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : Basic 1x2 demultiplexer with parameterized in/output widths
 * ----------------------------------------------------------------------------------- */

module demux_1x2#( parameter WIDTH = 4 )    (
                                                input [WIDTH-1:0] IN0,
                                                input SEL,
                                                output [WIDTH-1:0] OUT0,
                                                output [WIDTH-1:0] OUT1
                                            );

    reg [WIDTH-1:0] OUT0_r, OUT1_r;

    always@( * )
    begin
        OUT0_r = 0;
        OUT1_r = 0;

        if( !SEL )
        begin
            OUT0_r = IN0;
        end
        else if( SEL )
        begin
            OUT1_r = IN0;
        end
    end

    assign OUT0 = OUT0_r;
    assign OUT1 = OUT1_r;

endmodule
