/* -----------------------------------------------------------------------------------
 * Module Name  : xor_gate
 * Date Created : 00:18:20 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : Basic parameterized XOR gate
 * ----------------------------------------------------------------------------------- */

module xor_gate#( parameter WIDTH = 1 )(    input [WIDTH-1:0] IN0,
                                            input [WIDTH-1:0] IN1,
                                            output [WIDTH-1:0] OUT0 );

    assign OUT0 = IN0 ^ IN1;

endmodule
