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

// -----------------------------------------------------------------------------------
// Testbench
// -----------------------------------------------------------------------------------

module and_gate_top;

    reg I0, I1;
    wire Out;

    and_gate gate0( I0, I1, Out );

    initial
    begin
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
        I0 = 0;
        I1 = 0;
        #1;
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
        I0 = 0;
        I1 = 1;
        #1;
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
        I0 = 1;
        I1 = 0;
        #1;
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
        I0 = 1;
        I1 = 1;
        #1;
        $display( "I0 : %b, I1 : %b, Out : %b", I0, I1, Out );
    end
    
endmodule
