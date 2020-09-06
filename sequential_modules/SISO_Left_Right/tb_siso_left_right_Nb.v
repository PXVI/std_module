/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 12:23:11 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  : Simple testbench for a Left-Right SISO
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

`include "siso_left_right_Nb.v"

module siso_left_right_Nb_top;

    parameter W = 4, SW = 4;

    reg RST;
    reg CLK;
    reg [1:0] SHIFT;
    reg [W-1:0] IN;
    wire [W-1:0] OUT;

    siso_left_right_Nb #( .BUS_WIDTH( W ), .SISO_WIDTH( SW ) ) siso_l ( .RST( RST ), .CLK( CLK ), .SHIFT( SHIFT ), .IN( IN ), .OUT( OUT ) );

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
                repeat( (2**(SW+3))+16 )
                begin
                    @( posedge CLK );
                    #1;
                    $display( " A --- IN : %d, SHIFT : %0d == OUT : %d", IN, SHIFT, OUT );
                    SHIFT = 1;
                    IN = $urandom;
                    @( negedge CLK );
                end
                @( negedge CLK );
                repeat( (2**(SW+3))+16 )
                begin
                    @( posedge CLK );
                    #1;
                    $display( " B --- IN : %d, SHIFT : %0d == OUT : %d", IN, SHIFT, OUT );
                    SHIFT = 0;
                    IN = $urandom;
                    @( negedge CLK );
                end
                @( negedge CLK );
                repeat( (2**(SW+3))+16 )
                begin
                    @( posedge CLK );
                    #1;
                    $display( " C --- IN : %d, SHIFT : %0d == OUT : %d", IN, SHIFT, OUT );
                    SHIFT = 2;
                    IN = $urandom;
                    @( negedge CLK );
                end
                @( negedge CLK );
                repeat( (2**(SW+3))+16 )
                begin
                    @( posedge CLK );
                    #1;
                    $display( " D --- IN : %d, SHIFT : %0d == OUT : %d", IN, SHIFT, OUT );
                    SHIFT = 3;
                    IN = $urandom;
                    @( negedge CLK );
                end
                $finish;
            end
        join
    end

endmodule
