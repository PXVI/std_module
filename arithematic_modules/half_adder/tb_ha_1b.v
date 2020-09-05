/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 00:09:16 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  : Testbench for the 1 bit half adder
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

`include "ha_1b.v"

module tb_ha_1b;

    reg IN0, IN1;
    wire SUM, CO;

    ha_1b ha ( .IN0( IN0 ), .IN1( IN1 ), .SUM( SUM ), .CARRY_OUT( CO ) );

    initial
    begin
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUM : %0b, CO : %0b", IN0, IN1, SUM, CO );
        IN0 = 0;
        IN1 = 0;
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUM : %0b, CO : %0b", IN0, IN1, SUM, CO );
        IN0 = 0;
        IN1 = 1;
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUM : %0b, CO : %0b", IN0, IN1, SUM, CO );
        IN0 = 1;
        IN1 = 0;
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUM : %0b, CO : %0b", IN0, IN1, SUM, CO );
        IN0 = 1;
        IN1 = 1;
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUM : %0b, CO : %0b", IN0, IN1, SUM, CO );
    end

endmodule
