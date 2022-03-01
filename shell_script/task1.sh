#!/bin/sh
# Author : Zihao
# Descrption: measure periceved time for one picture

VAR=`ls ./images/part1-image/*`

echo "uploading..."
for entry in $VAR
do
  $(aws s3 cp $entry s3://cloudcomputingproject2)
done

a=0
while [ $a -lt 1 ]
do
    VAR1=`aws s3 ls s3://cloudcomputingproject2-resized | grep "success" | wc -l`
    if [ $VAR1 -gt 0 ]
    then
        break
    fi
done

echo "downloading..."

`aws s3 cp s3://cloudcomputingproject2-resized ./download/part1-image --recursive`

while [ $a -lt 1 ]
do
    VAR2=`ls ./download/part1-image/ | grep "success" | wc -l`
    if [ $VAR2 -gt 0 ]
    then   
        break
    fi
done

echo "done"