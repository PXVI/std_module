/* -----------------------------------------------------------------------------------
 * Module Name  : async_fifo_v1
 * Date Created : 10:12:50 IST, 05 September, 2020 [ Saturday ]
 *
 * Author       : pxvi
 * Description  : An asynchronous FIFO block with parameterized depth. The
 *                FIFO has these core functionalities -
 *                1. Two input Clock Frequencies
 *                2. One async reset pin
 *                3. 8 bit data bus
 *                4. Additional pin called H_Flush ( Flushes half the FIFO )
 *                5. Standard outputs like, FULL, EMPTY & DATA_OUT
 *                6. Additional output pin, H_FULL ( Sets when FIFO is atleast
 *                half full )
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

module async_fifo_v1 #( parameter BUS_WIDTH = 8, FIFO_DEPTH = 16 )  (
                                                                        input RST,
                                                                        input CLK_WR,
                                                                        input CLK_RD,
                                                                        input [BUS_WIDTH-1:0] DATA_IN,
                                                                        input WR_EN,
                                                                        input RD_EN,
                                                                        input H_FLUSH,

                                                                        output reg [BUS_WIDTH-1:0] DATA_OUT,
                                                                        output FULL,
                                                                        output EMPTY,
                                                                        output H_FULL
                                                                    );

    
    parameter PTR_WIDTH = $clog2( FIFO_DEPTH );
    integer i = 0;

    reg [PTR_WIDTH:0] wr_ptr, rd_ptr;
    reg [PTR_WIDTH:0] fifo_count_p;
    reg [PTR_WIDTH:0] fifo_count_n;

    reg [BUS_WIDTH-1:0] MEM [FIFO_DEPTH-1:0];

    // FIFO Counter
    always@(*)
    begin
        if( !FULL && WR_EN && fifo_count_p != 'd16 )
        begin
            fifo_count_n = fifo_count_p + 1;
        end
        if( !EMPTY && RD_EN && fifo_count_p != 'd0 )
        begin
            fifo_count_n = fifo_count_p - 1;
        end
        if( H_FLUSH && !EMPTY )
        begin
            fifo_count_n = ( fifo_count_p / 2 );
        end
    end

    // FIFO Write Module
    always@( posedge CLK_WR or posedge RST )
    begin
        wr_ptr <= wr_ptr;
        fifo_count_p <= fifo_count_p;

        for( i = 0; i < FIFO_DEPTH; i = i + 1 )
        begin
            MEM[i] <= MEM[i];
        end

        if( RST )
        begin
            wr_ptr <= 0;
            fifo_count_p <= 0;
        end
        else
        begin
            fifo_count_p <= fifo_count_n;

            if( !FULL && WR_EN )
            begin
                wr_ptr <= wr_ptr + 1'b1;
                MEM[wr_ptr[PTR_WIDTH-1:0]] <= DATA_IN;
            end
        end
    end

    // FIFO Read Module
    always@( posedge CLK_RD or posedge RST )
    begin
        rd_ptr <= rd_ptr;
        DATA_OUT <= DATA_OUT;

        if( RST )
        begin
            rd_ptr <= 0;
        end
        else
        begin
            if( !EMPTY && H_FLUSH )
            begin
                rd_ptr <= rd_ptr + ( fifo_count_p - ( fifo_count_p / 2 ) );
                //if( RD_EN )
                //begin
                //    rd_ptr <= rd_ptr + 1'b1;
                //    DATA_OUT <= MEM[rd_ptr[PTR_WIDTH-1:0]];
                //end
            end
            else if( !EMPTY && RD_EN )
            begin
                rd_ptr <= rd_ptr + 1'b1;
                DATA_OUT <= MEM[rd_ptr[PTR_WIDTH-1:0]];
            end
        end
    end

    assign FULL = ( rd_ptr[PTR_WIDTH-1:0] == wr_ptr[PTR_WIDTH-1:0] && rd_ptr[PTR_WIDTH] != wr_ptr[PTR_WIDTH] ) ? 1'b1 : 1'b0;
    assign EMPTY = ( rd_ptr[PTR_WIDTH-1:0] == wr_ptr[PTR_WIDTH-1:0] && rd_ptr[PTR_WIDTH] == wr_ptr[PTR_WIDTH] ) ? 1'b1 : 1'b0;
    assign H_FULL = ( fifo_count_p > ((FIFO_DEPTH/2)-1) ) ? 1'b1 : 1'b0;

    initial
    begin
        //$monitor( $time, " Module : RD_PTR : ( %0b, %0d ), WR_PTR : ( %0b, %0d ), fifo_count_p : %0d ", rd_ptr[PTR_WIDTH], rd_ptr[PTR_WIDTH-1:0], wr_ptr[PTR_WIDTH], wr_ptr[PTR_WIDTH-1:0], fifo_count_p );
    end

endmodule
