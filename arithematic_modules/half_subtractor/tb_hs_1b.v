/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 00:41:32 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  : Testbench for the 1 bit half subtractor
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
   AUTHORS OR BOPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF BONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN BONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.

 * ----------------------------------------------------------------------------------- */

`include "hs_1b.v"

module tb_hs_1b;

    reg IN0, IN1;
    wire SUB, BO;

    hs_1b hs ( .IN0( IN0 ), .IN1( IN1 ), .SUB( SUB ), .BORROW_OUT( BO ) );

    initial
    begin
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUB : %0b, BO : %0b", IN0, IN1, SUB, BO );
        IN0 = 0;
        IN1 = 0;
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUB : %0b, BO : %0b", IN0, IN1, SUB, BO );
        IN0 = 0;
        IN1 = 1;
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUB : %0b, BO : %0b", IN0, IN1, SUB, BO );
        IN0 = 1;
        IN1 = 0;
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUB : %0b, BO : %0b", IN0, IN1, SUB, BO );
        IN0 = 1;
        IN1 = 1;
        #1;
        $display( "IN0 : %0b, IN1 : %0b, SUB : %0b, BO : %0b", IN0, IN1, SUB, BO );
    end

endmodule
