#!/bin/bash
export SLICES_COUNT=$1

mkdir /tmp/data-debug/out/tables/slice.csv
for j in `seq 1 $SLICES_COUNT`;
do
    mv /tmp/data-debug/in/files/slice/random$j /tmp/data-debug/out/tables/slice.csv/
done
