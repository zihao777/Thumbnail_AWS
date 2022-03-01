#!/bin/sh
# Author : Zihao
# Descrption: measure periceved time for 100 pictures

VAR=`ls ./images/part2-images/*`

echo "uploading..."
# `aws s3 cp ./images/part2-images/ s3://cloudcomputingproject2 --recursive`
for entry in $VAR
do
 $(aws s3 cp $entry s3://cloudcomputingproject2)
done

a=0
while [ $a -lt 1 ]
do
    VAR1=`aws s3 ls s3://cloudcomputingproject2-resized | wc -l`
    if [ $VAR1 -eq 101 ]
    then
        break
    fi
done

echo "downloading..."
for entry1 in $VAR
do
    BASENAME=$(basename $entry1)
    FILE="s3://cloudcomputingproject2-resized/${BASENAME}"
    `aws s3 cp ${FILE} ./download/part2-images`
done
# `aws s3 cp s3://cloudcomputingproject2-resized ./download/part2-images --recursive`

while [ $a -lt 1 ]
do
    VAR3=`ls ./download/part2-images/| wc -l`
    if [ $VAR3 -eq 100 ]
    then   
        break
    fi
done

echo "done"