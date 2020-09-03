# * -----------------------------------------------------------------------------------
# * Script Name  : script_semux_1xN
# * Date Created : 22:41:16 IST, 03 September, 2020 [ Thursday ]
# *
# * Author       : pxvi
# * Description  : Script to generate a 1xN de-multiplexer module
# * ----------------------------------------------------------------------------------- */

if [ $# -eq 0 ]
then
    echo -n "De-multiplexer module generation script. Enter the value of N in 1xN : ";
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

        echo "" > demux_1x${N_val}.v;
        
        echo "module demux_1x${N_val}#( parameter WIDTH = 4 )    (" >> demux_1x${N_val}.v;
        echo "                                                input [WIDTH-1:0] IN0," >> demux_1x${N_val}.v;
        echo "                                                input [${actual_log2}-1:0] SEL," >> demux_1x${N_val}.v;
 
        i="0";
        while [ $i -lt ${N_val} ]
        do
            if [ ${N_val} = "$i" ]
            then
                echo "                                                output [WIDTH-1:0] OUT${i}," >> demux_1x${N_val}.v;
            else
                echo "                                                output [WIDTH-1:0] OUT${i}" >> demux_1x${N_val}.v;
            fi
            i=`expr $i + 1`;
        done

        echo "                                            );" >> demux_1x${N_val}.v;
        echo "" >> demux_1x${N_val}.v;

        i="0";
        while [ $i -lt ${N_val} ]
        do
            echo "    reg [WIDTH-1:0] OUT${i}_r;" >> demux_1x${N_val}.v;

            i=`expr $i + 1`;
        done

        echo "" >> demux_1x${N_val}.v;
        echo "    always@( * )" >> demux_1x${N_val}.v;
        echo "    begin" >> demux_1x${N_val}.v;

        i="0";
        while [ $i -lt ${N_val} ]
        do
            echo "        OUT${i}_r = 0;" >> demux_1x${N_val}.v;
            i=`expr $i + 1`;
        done

        echo "" >> demux_1x${N_val}.v;

        echo "        if( SEL == 'd0 )" >> demux_1x${N_val}.v;
        echo "        begin" >> demux_1x${N_val}.v;
        echo "            OUT0_r = IN0;" >> demux_1x${N_val}.v;
        echo "        end" >> demux_1x${N_val}.v;

        i="1";
        while [ $i -lt ${N_val} ]
        do
            echo "        else if( SEL == 'd${i} )" >> demux_1x${N_val}.v;
            echo "        begin" >> demux_1x${N_val}.v;
            echo "            OUT${i}_r = IN0;" >> demux_1x${N_val}.v;
            echo "        end" >> demux_1x${N_val}.v;
            i=`expr $i + 1`;
        done

        echo "    end" >> demux_1x${N_val}.v;
        echo "" >> demux_1x${N_val}.v;

        i="0";
        while [ $i -lt ${N_val} ]
        do
            echo "    assign OUT${i} = OUT${i}_r;" >> demux_1x${N_val}.v;
            i=`expr $i + 1`;
        done

        echo "" >> demux_1x${N_val}.v;
        echo "endmodule" >> demux_1x${N_val}.v;

    else
        echo "Invalid input. Try again."
    fi
else
    echo "Invalid arguments. Just run the script as it is."
fi
