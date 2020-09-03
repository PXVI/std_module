/* -----------------------------------------------------------------------------------
 * Module Name  : and_gate
 * Date Created : 23:53:16 IST, 02 September, 2020 [ Wednesday ]
 *
 * Author       : pxvi
 * Description  : Basic parameterized AND gate module.
 * ----------------------------------------------------------------------------------- */

module and_gate#( parameter WIDTH = 1 )(    input [WIDTH-1:0] IN0,
                                            input [WIDTH-1:0] IN1,
                                            output [WIDTH-1:0] OUT0 );

    assign OUT0 = IN0 & IN1;

endmodule

