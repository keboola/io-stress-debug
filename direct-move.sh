#!/bin/bash
export SLICES_COUNT=$1

# mkdir $KBC_DATADIR/out/tables/slice.csv

#for j in `seq 1 $SLICES_COUNT`;
#do
#    mv $KBC_DATADIR/in/files/slice/random$j $KBC_DATADIR/out/tables/slice.csv/
#done

cd $KBC_DATADIR/in/files

find . ! -iname "*.manifest" ! -name "." -type d | wc -l
find . ! -iname "*.manifest" ! -name "." -type d | xargs -n1 -I {} mv {} $KBC_DATADIR/out/tables/{}.csv
ls $KBC_DATADIR/in/files/slice | wc -l
ls $KBC_DATADIR/out/tables/slice.csv | wc -l
find . ! -iname "*.manifest" ! -name "." | xargs -n1 -I {} mv {} $KBC_DATADIR/out/tables/{}.csv
