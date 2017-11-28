#!/bin/sh
export ITERATIONS=100
round()
{
    echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};

for j in `seq 1 $ITERATIONS`;
do
    cat /tmp/source > /tmp/random$1
    echo -ne "$(round $j/$ITERATIONS 2)\r"
done
echo ""
