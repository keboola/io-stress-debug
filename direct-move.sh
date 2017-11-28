#!/bin/bash
set -e
export SLICES_COUNT=$1

# mkdir $KBC_DATADIR/out/tables/slice.csv

#for j in `seq 1 $SLICES_COUNT`;
#do
#    mv $KBC_DATADIR/in/files/slice/random$j $KBC_DATADIR/out/tables/slice.csv/
#done

cd $KBC_DATADIR/in/files

echo "Dirs in $KBC_DATADIR/in/files"
find . ! -iname "*.manifest" ! -name "." -type d | wc -l
echo "Files in $KBC_DATADIR/in/files"
ls $KBC_DATADIR/in/files | wc -l
echo "Files in $KBC_DATADIR/in/files/slice"
ls $KBC_DATADIR/in/files/slice | wc -l
find . --maxdepth 1 ! -iname "*.manifest" ! -name "." -type d  | xargs -n1 -I {} mv -v {} $KBC_DATADIR/out/tables/{}.csv
echo "Files in $KBC_DATADIR/in/files/slice"
ls $KBC_DATADIR/in/files/slice | wc -l
echo "Files in $KBC_DATADIR/out/tables/slice.csv"
ls $KBC_DATADIR/out/tables/slice.csv | wc -l
echo "Files in $KBC_DATADIR/in/files"
ls $KBC_DATADIR/in/files | wc -l
find . ! -iname "*.manifest" ! -name "." | xargs -n1 -I {} mv -v {} $KBC_DATADIR/out/tables/{}.csv
echo "Files in $KBC_DATADIR/out/tables"
ls $KBC_DATADIR/out/tables | wc -l
