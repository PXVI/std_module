# * -----------------------------------------------------------------------------------
# * Module Name  : script_mux_Nx1
# * Date Created : 23:53:41 IST, 03 September, 2020 [ Thursday ]
# *
# * Author       : pxvi
# * Description  : Script to generate a Nx1 multiplexer module
# * ----------------------------------------------------------------------------------- */

if [ $# -eq 0 ]
then
    echo -n "Multiplexer module generation script. Enter the value of N in Nx1 : ";
    read N_val;

    if [ $N_val -ge 2 ]
    then
        decimal_log2=`echo "l(${N_val})/l(2)" | bc -l`;
        actual_log2=${decimal_log2/\.*/}
        power2=`echo $(( 2 ** $actual_log2 )) `;

        if [ "$power2" != "$N_val" ]
        then
            actual_log2=`expr $actual_log2 + 1`;
        fi

        echo "" > mux_${N_val}x1.v;
    
        echo "module mux_${N_val}x1#( parameter WIDTH = 4 )(" >> mux_${N_val}x1.v;

        i="0";
        while [ $i -lt ${N_val} ]
        do
            echo "                                            input [WIDTH-1:0] IN${i}," >> mux_${N_val}x1.v;
            i=`expr $i + 1`;
        done

        echo "                                            input [${actual_log2}-1:0] SEL," >> mux_${N_val}x1.v;
        echo "                                            output [WIDTH-1:0] OUT0 );" >> mux_${N_val}x1.v;
        echo "" >> mux_${N_val}x1.v;
        echo "    reg [WIDTH-1:0] OUT0_r;" >> mux_${N_val}x1.v;
        echo "" >> mux_${N_val}x1.v;
        echo "    always@( * )" >> mux_${N_val}x1.v;
        echo "    begin" >> mux_${N_val}x1.v;
        echo "        if( SEL == 'd0 )" >> mux_${N_val}x1.v;
        echo "        begin" >> mux_${N_val}x1.v;
        echo "            OUT0_r = IN0;" >> mux_${N_val}x1.v;
        echo "        end" >> mux_${N_val}x1.v;

        i="1";
        while [ $i -lt ${N_val} ]
        do
            echo "        else if( SEL == 'd${i} )" >> mux_${N_val}x1.v;
            echo "        begin" >> mux_${N_val}x1.v;
            echo "            OUT0_r = IN${i};" >> mux_${N_val}x1.v;
            echo "        end" >> mux_${N_val}x1.v;
            i=`expr $i + 1`;
        done

        echo "    end" >> mux_${N_val}x1.v;
        echo "" >> mux_${N_val}x1.v;
        echo "    assign OUT0 = OUT0_r;" >> mux_${N_val}x1.v;
        echo "" >> mux_${N_val}x1.v;
        echo "endmodule" >> mux_${N_val}x1.v;

    else
        echo "Invalid input. Try again."
    fi
else
    echo "Invalid arguments. Just run the script as it is."
fi
