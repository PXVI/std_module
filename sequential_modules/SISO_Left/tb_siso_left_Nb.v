/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 10:47:43 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  : Simple testbench for the left shift siso
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

`include "siso_left_Nb.v"

module siso_left_Nb_top;

    parameter W = 4, SW = 4;

    reg RST;
    reg CLK;
    reg LSHIFT;
    reg [W-1:0] IN;
    wire [W-1:0] OUT;

    siso_left_Nb #( .BUS_WIDTH( W ), .SISO_WIDTH( SW ) ) siso_l ( .RST( RST ), .CLK( CLK ), .LSHIFT( LSHIFT ), .IN( IN ), .OUT( OUT ) );

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
                repeat( (2**(SW+1))+16 )
                begin
                    @( posedge CLK );
                    #1;
                    $display( "IN : %d, LSHIFT : %0d == OUT : %d", IN, LSHIFT, OUT );
                    LSHIFT = 1;
                    IN = $urandom;
                    @( negedge CLK );
                end
                $finish;
            end
        join
    end

endmodule
