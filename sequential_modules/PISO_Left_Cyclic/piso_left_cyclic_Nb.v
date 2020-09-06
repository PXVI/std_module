/* -----------------------------------------------------------------------------------
 * Module Name  : piso_left_Nb
 * Date Created : 12:51:26 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  : Basic parallel in Serial out cyclic left shifter
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

module piso_left_cyclic_Nb #( parameter BUS_WIDTH = 8, SISO_WIDTH = 4 ) (
                                                                            input RST,
                                                                            input CLK,
                                                                            input LOAD,
                                                                            input LSHIFT,
                                                                            // Add more signals depending on the SISO_WIDTH parameter
                                                                            input [BUS_WIDTH-1:0] IN0,
                                                                            input [BUS_WIDTH-1:0] IN1,
                                                                            input [BUS_WIDTH-1:0] IN2,
                                                                            input [BUS_WIDTH-1:0] IN3,
                                                                            output [BUS_WIDTH-1:0] OUT
                                                                        );

    reg [BUS_WIDTH-1:0] siso_mem_p[SISO_WIDTH-1:0], siso_mem_n[SISO_WIDTH-1:0];
    integer i = 0, j = 0;
    wire [BUS_WIDTH-1:0] temp_in_val[SISO_WIDTH-1:0];

    // If SISO_WIDTH is to be changed then add new assign statements here
    assign temp_in_val[0] = IN0;
    assign temp_in_val[1] = IN1;
    assign temp_in_val[2] = IN2;
    assign temp_in_val[3] = IN3;

    always@(*)
    begin
        if( LOAD )
        begin   
            for( i = 0; i < SISO_WIDTH; i = i + 1 )
            begin
                    siso_mem_n[i] = temp_in_val[i];
            end
        end
        else if( LSHIFT )
        begin
            for( i = SISO_WIDTH-1; i >= 0; i = i - 1 )
            begin
                if( i == 0 )
                begin
                    siso_mem_n[i] = siso_mem_p[SISO_WIDTH-1];
                end
                else
                begin
                    siso_mem_n[i] = siso_mem_p[i-1];
                end
            end
        end
    end

    always@( posedge CLK or posedge RST )
    begin
        for( j = 0; j < SISO_WIDTH; j = j + 1 )
        begin
            siso_mem_p[j] <= siso_mem_p[j];
        end

        if( RST )
        begin
            // Does nothing actually
        end
        else
        begin
            for( j = 0; j < SISO_WIDTH; j = j + 1 )
            begin
                siso_mem_p[j] <= siso_mem_n[j];
            end
        end
    end

    assign OUT = siso_mem_p[SISO_WIDTH-1];

endmodule
