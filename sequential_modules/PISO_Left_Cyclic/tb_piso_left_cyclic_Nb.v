/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 13:01:23 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  : Testbench for a simple PISO cyclic left shifter
 * -----------------------------------------------------------------------------------

   MIT License

   Copyright (c) 2020 k-sva

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the Software), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.

 * ----------------------------------------------------------------------------------- */

`include "piso_left_cyclic_Nb.v"

module piso_left_cyclic_Nb_top;

    parameter W = 4, SW = 4;

    reg RST;
    reg CLK;
    reg LOAD;
    reg LSHIFT;
    reg [W-1:0] IN [SW-1:0];
    wire [W-1:0] OUT;
    integer i = 0;

    piso_left_cyclic_Nb #( .BUS_WIDTH( W ), .SISO_WIDTH( SW ) ) piso_l ( .RST( RST ), .CLK( CLK ), .LOAD( LOAD ), .LSHIFT( LSHIFT ), .IN0( IN[0] ), .IN1( IN[1] ), .IN2( IN[2] ), .IN3( IN[3] ), .OUT( OUT ) );

    initial
    begin
        RST = 1;
        #100 RST = 0;
        
        fork
            begin
                CLK = 1;
                forever
                begin
                    #5 CLK = ~CLK;
                end
            end
            begin
                @( negedge CLK );
                repeat( 2 )
                begin
                    @( posedge CLK );
                    #1;
                    for( i = 0; i < SW; i = i + 1 )
                    begin
                        $display( "IN[%0d] : %0d", i, IN[i] );
                    end
                    $display( "LOAD : %0d, LSHIFT : %0d == OUT : %d", LOAD, LSHIFT, OUT );
                    LSHIFT = 1;
                    LOAD = 0;
                    for( i = 0; i < SW; i = i + 1 )
                    begin
                        IN[i] = $urandom;
                    end
                    @( negedge CLK );
                end
                repeat( 1 )
                begin
                    @( posedge CLK );
                    #1;
                    for( i = 0; i < SW; i = i + 1 )
                    begin
                        $display( "IN[%0d] : %0d", i, IN[i] );
                    end
                    $display( "LOAD : %0d, LSHIFT : %0d == OUT : %d", LOAD, LSHIFT, OUT );
                    LSHIFT = 1;
                    LOAD = 1;
                    for( i = 0; i < SW; i = i + 1 )
                    begin
                        IN[i] = $urandom;
                    end
                    @( negedge CLK );
                end
                repeat( 8 )
                begin
                    @( posedge CLK );
                    #1;
                    for( i = 0; i < SW; i = i + 1 )
                    begin
                        $display( "IN[%0d] : %0d", i, IN[i] );
                    end
                    $display( "LOAD : %0d, LSHIFT : %0d == OUT : %d", LOAD, LSHIFT, OUT );
                    LSHIFT = 1;
                    LOAD = 0;
                    for( i = 0; i < SW; i = i + 1 )
                    begin
                        IN[i] = $urandom;
                    end
                    @( negedge CLK );
                end
                $finish;
            end
        join
    end

endmodule
