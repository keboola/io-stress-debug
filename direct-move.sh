#!/bin/bash
export SLICES_COUNT=$1

mkdir $KBC_DATADIR/out/tables/slice.csv
for j in `seq 1 $SLICES_COUNT`;
do
    mv $KBC_DATADIR/in/files/slice/random$j $KBC_DATADIR/out/tables/slice.csv/
done
