#!/bin/sh
# Author : Zihao
# Descrption: measure total time of back upload and download 100 pictures.

VAR=`ls ./images/part2-images/*`

echo "uploading..."
`aws s3 cp ./images/part2-images/ s3://cloudcomputingproject2 --recursive`

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

`aws s3 cp s3://cloudcomputingproject2-resized ./download/part2-images --recursive`

while [ $a -lt 1 ]
do
    VAR2=`ls ./download/part2-images/ |  wc -l`
    if [ $VAR2 -eq 101 ]
    then   
        break
    fi
done

echo "done"