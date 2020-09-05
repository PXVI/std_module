/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 10:13:00 IST, 05 September, 2020 [ Saturday ]
 *
 * Author       : pxvi
 * Description  : Basic testbench for the async fifo v1 module
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

`include "async_fifo_v1.v"

module async_fifo_v1_top;

    parameter   BUS_WIDTH = 8,
                FIFO_DEPTH = 16;

    reg RST;
    reg CLK_WR;
    reg CLK_RD;
    reg [BUS_WIDTH-1:0] DATA_IN;
    reg WR_EN;
    reg RD_EN;
    reg H_FLUSH;

    wire [BUS_WIDTH-1:0] DATA_OUT;
    wire FULL;
    wire EMPTY;
    wire H_FUL;

    async_fifo_v1 #( .BUS_WIDTH( BUS_WIDTH ), .FIFO_DEPTH( FIFO_DEPTH ) ) fifo  (
                                                                                    .RST( RST ),
                                                                                    .CLK_WR( CLK_WR ),
                                                                                    .CLK_RD( CLK_RD ),
                                                                                    .DATA_IN( DATA_IN ),
                                                                                    .WR_EN( WR_EN ),
                                                                                    .RD_EN( RD_EN ),
                                                                                    .H_FLUSH( H_FLUSH ),
                                                                                    .DATA_OUT( DATA_OUT ),
                                                                                    .FULL( FULL ),
                                                                                    .EMPTY( EMPTY ),
                                                                                    .H_FULL( H_FULL )
                                                                                );

    initial
    begin
        fork
            begin // Clocks
                fork
                    begin
                        CLK_WR = 0;
                        forever
                        begin
                            #5 CLK_WR = ~CLK_WR;
                        end
                    end
                    begin
                        CLK_RD = 0;
                        forever
                        begin
                            #5 CLK_RD = ~CLK_RD;
                        end
                    end
                join
            end
            begin // Stimulus
                RST = 1;
                #100 RST = 0;
                fork
                    begin : WRITE // Write
                        integer i;
                        i = $urandom % 100;

                        $display( $time, " Write %0d time", i );

                        repeat( i )
                        begin
                            @( negedge CLK_WR );
                            WR_EN = 1;
                            DATA_IN = $urandom % 100;
                            $display( $time, " FULL : %0d, EMPTY = %0d, H_FULL = %0d, Data trying to write : %0d", FULL, EMPTY, H_FULL, DATA_IN );
                            //@( negedge CLK_WR );
                            //WR_EN = 0;
                        end
                        @( negedge CLK_WR );
                        WR_EN = 0;
                        H_FLUSH = 1;
                        @( negedge CLK_WR );
                        $display( $time, " FULL : %0d, EMPTY = %0d, H_FULL = %0d, Data trying to read : %0d", FULL, EMPTY, H_FULL, DATA_OUT );
                        H_FLUSH = 0;
                        //@( negedge CLK_WR );
                        repeat( 64 )
                        begin
                            //@( negedge CLK_WR );
                            RD_EN = 1;
                            $display( $time, " FULL : %0d, EMPTY = %0d, H_FULL = %0d, Data trying to read : %0d", FULL, EMPTY, H_FULL, DATA_OUT );
                            @( negedge CLK_RD );
                            //RD_EN = 0;
                        end
                    end : WRITE
                    //begin : READ // Read
                    //    integer i;
                    //    i = $urandom % 50;

                    //    $display( $time, " Read %0d time", i );

                    //    repeat( i )
                    //    begin
                    //        repeat( ( $urandom % 4 ) + 1 )
                    //        begin
                    //            @( negedge CLK_RD );
                    //        end
                    //        RD_EN = 1;
                    //        RD_EN = #6 0;
                    //        @( negedge CLK_RD );
                    //        $display( $time, " FULL : %0d, EMPTY = %0d, H_FULL = %0d, Data beign popped : %0d", FULL, EMPTY, H_FULL, DATA_OUT );
                    //    end
                    //end : READ
                join
            end
            begin // Sim end time
                #20000;
                $finish;
            end
        join
    end

    initial
    begin
        $dumpfile( "fifo_dump.vcd" );
        $dumpvars( 1,fifo,RST,CLK_WR,CLK_RD,DATA_IN,WR_EN,RD_EN,H_FLUSH,DATA_OUT,FULL,EMPTY,H_FULL );
    end

endmodule
