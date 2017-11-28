#!/bin/sh
set -e
export FILE_SIZE=$1
export SLICES_COUNT=$2

# prepare folder structure
echo "Preparing folder structure"
rm -rf /tmp/debug-data
mkdir /tmp/debug-data
mkdir /tmp/debug-data/out
mkdir /tmp/debug-data/out/files
mkdir /tmp/debug-data/out/tables
mkdir /tmp/debug-data/out/files/slice

# generate 1MB file
echo "Creating base file"
openssl rand -out /tmp/source-file -base64 $FILE_SIZE

round()
{
    echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};

# generate slices
echo "Generating slices"
for j in `seq 1 $SLICES_COUNT`;
do
    cp /tmp/source-file /tmp/debug-data/out/files/slice/random$j
    echo -ne "$(round $j/$SLICES_COUNT 2)\r"
done
echo ""

# mock docker runner step between containers
echo "Moving directories"
mv /tmp/debug-data/out /tmp/debug-data/in
mkdir /tmp/debug-data/out
mkdir /tmp/debug-data/out/files
mkdir /tmp/debug-data/out/tables

# echo "Running processor-move-files"
# docker run --rm --volume /root/debug/processor.sh:/root/processor.sh --volume /tmp/debug-data:/data --memory 128m --memory-swap 128m --cpu-shares 1024 --net bridge --env KBC_PARAMETER_DIRECTION=tables --env KBC_PARAMETER_ADDCSVSUFFIX=1 --env KBC_DATADIR=/data/ 147946154733.dkr.ecr.us-east-1.amazonaws.com/developer-portal-v2/keboola.processor-move-files:1.1.0 /bin/sh /root/processor.sh

# echo "Running move script directly"
# export KBC_DATADIR=/tmp/debug-data
# export KBC_PARAMETER_ADDCSVSUFFIX=1
# export KBC_PARAMETER_DIRECTION=tables
# ./processor.sh

echo "Listing files directly"
ls /tmp/debug-data/in/files/slice | wc -l

# echo "Listing files in docker"
# docker run --rm --volume /tmp/debug-data:/data --volume /root/debug/processor.sh:/root/processor.sh --memory 128m --memory-swap 128m --cpu-shares 1024 --net bridge alpine:latest ls /data/in/files/slice/ | wc -l

echo "Running alpine image"
docker run --rm --volume /tmp/debug-data:/data --volume `pwd`:/root --memory 128m --memory-swap 128m --cpu-shares 1024 --net bridge --env KBC_PARAMETER_DIRECTION=tables --env KBC_PARAMETER_ADDCSVSUFFIX=1 --env KBC_DATADIR=/data/ alpine:latest /bin/sh /root/direct-move.sh $SLICES_COUNT

# rm -rf /tmp/debug-data
