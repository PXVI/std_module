/* -----------------------------------------------------------------------------------
 * Module Name  :
 * Date Created : 00:53:28 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  :
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

`include "fs_Nb.v"

module fs_Nb_top;

    parameter W = 2;

    reg [W-1:0] IN0, IN1;
    reg BIN;
    wire [W-1:0] SUB;
    wire BO;
    reg signed [W:0] signed_out;

    fs_Nb #( .WIDTH( W ) ) fs ( .BORROW_IN( BIN ), .IN0( IN0 ), .IN1( IN1 ), .SUB( SUB ), .BORROW_OUT( BO ) );

    integer i = 0;

    initial
    begin
        for( i = 0; i <= 2**(2*W+1); i = i + 1 )
        begin
            signed_out = {BO,SUB};
            $display( "BIN : %0b, IN0 : %0d, IN1 : %0d == SUB : %0d, BO : %0d ( %0d )", BIN, IN0, IN1, {SUB}, BO, signed_out );
            {BIN,IN0,IN1} = i;
            #1;
            //if( ( BIN - IN0 - IN1 ) != ( {BO,SUB} ) )
            //begin
            //    $display( "Error Information Mismatch" );
            //    $display( "BIN : %0b, IN0 : %0d, IN1 : %0d == SUB : %0d, BO : %0d", BIN, IN0, IN1, {SUB}, BO );
            //    $finish;
            //end
        end
    end

endmodule
