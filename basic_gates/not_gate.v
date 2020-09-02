/* -----------------------------------------------------------------------------------
 * Module Name  : not_gate
 * Date Created : 00:18:20 IST, 03 September, 2020 [ Thursday ]
 *
 * Author       : pxvi
 * Description  : Basic parameterized NOT gate
 * ----------------------------------------------------------------------------------- */

module not_gate#( parameter WIDTH = 1 )(    input [WIDTH-1:0] IN0,
                                            output [WIDTH-1:0] OUT0 );

    assign OUT0 = ~( IN0 );

endmodule

// -----------------------------------------------------------------------------------
// Testbench
// -----------------------------------------------------------------------------------

module not_gate_top;

    reg I0;
    wire Out;

    not_gate gate0( I0, Out );

    initial
    begin
        $display( "I0 : %b, Out : %b", I0, Out );
        I0 = 0;
        #1;
        $display( "I0 : %b, Out : %b", I0, Out );
        I0 = 1;
        #1;
        $display( "I0 : %b, Out : %b", I0, Out );
    end
    
endmodule
