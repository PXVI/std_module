/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 22:42:24 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  : Simple testbench for the synchronous FIFO
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

`include "syn_fifo_v1_Nb.v"

module syn_fifo_v1_Nb_top;

    parameter W = 8, D = 8;

    reg RSTn;
    reg CLK;
    reg [W-1:0] DATA_IN;
    reg WR_EN;
    reg RD_EN;
    wire FULL;
    wire EMPTY;
    wire [W-1:0] DATA_OUT;

    syn_fifo_v1_Nb#( .BUS_WIDTH( W ), .FIFO_DEPTH( D ) ) fifo ( .RSTn( RSTn ), .CLK( CLK ), .DATA_IN( DATA_IN ), .WR_EN( WR_EN ), .RD_EN( RD_EN ), .FULL( FULL ), .EMPTY( EMPTY ), .DATA_OUT( DATA_OUT ) );

    initial
    begin
        fork
            begin
                CLK = 1;
                forever
                begin
                    #5 CLK = ~CLK;
                end
            end
            begin
                RSTn = 0;
                WR_EN = 0;
                RD_EN = 0;
                DATA_IN = 0;
                #100 RSTn = 1;
                begin
                    repeat( 32 )
                    begin
                        @( posedge CLK );
                        #1;
                        $display( $time, "  WR_EN ; %0d, RD_EN : %0d, DATA_IN : %0d :: FULL : %0d, EMPTY : %0d, DATA_OUT : %0d", WR_EN, RD_EN, DATA_IN, FULL, EMPTY, DATA_OUT );
                        @( negedge CLK );
                        WR_EN = 1;
                        DATA_IN = $urandom % 100;
                    end
                    WR_EN = 0;
                    repeat( 32 )
                    begin
                        @( posedge CLK );
                        #1;
                        $display( $time, "  WR_EN ; %0d, RD_EN : %0d, DATA_IN : %0d :: FULL : %0d, EMPTY : %0d, DATA_OUT : %0d", WR_EN, RD_EN, DATA_IN, FULL, EMPTY, DATA_OUT );
                        @( negedge CLK );
                        RD_EN = 1;
                    end
                end
                $finish;
            end
        join
    end

endmodule
