/* -----------------------------------------------------------------------------------
 * Module Name  : fa_Nb
 * Date Created : 00:17:20 IST, 06 September, 2020 [ Sunday ]
 *
 * Author       : pxvi
 * Description  : Parameterized N bit full adder in rtl
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

module fa_Nb #( parameter WIDTH = 4 )   (
                                        input CARRY_IN,
                                        input [WIDTH-1:0] IN0,
                                        input [WIDTH-1:0] IN1,
                                        output [WIDTH-1:0] SUM,
                                        output CARRY_OUT
                                    );

    reg [WIDTH-1:0] temp_sum;
    reg temp_carry;

    integer i = 0;

    always@(*)
    begin
        for( i = 0; i < WIDTH; i = i + 1 )
        begin
            if( i == 0 )
            begin
                temp_sum[i] = CARRY_IN ^ IN0[i] ^ IN1[i];
                temp_carry = ( CARRY_IN & IN0[i] ) | ( CARRY_IN & IN1[i] ) | ( IN0[i] & IN1[i] );
            end
            else
            begin
                temp_sum[i] = temp_carry ^ IN0[i] ^ IN1[i];
                temp_carry = ( temp_carry & IN0[i] ) | ( temp_carry & IN1[i] ) | ( IN0[i] & IN1[i] );
            end
        end
    end

    assign SUM = temp_sum;
    assign CARRY_OUT = temp_carry;

endmodule
