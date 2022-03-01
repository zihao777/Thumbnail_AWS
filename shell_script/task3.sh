#!/bin/sh
#Author: Zihao Zhou
#Measure preceived-time of each picture

VAR=`ls ./images/part2-images/*`
a=0

echo "size, time" >> ../data.csv

echo "measuring..."
for entry in $VAR
do
    TIMESTART=$(date +%s)
    `aws s3 cp $entry s3://cloudcomputingproject2`
    while [ $a -lt 1 ]
    do
        VAR1=`aws s3 ls s3://cloudcomputingproject2-resized | grep "success" | wc -l`
        if [ $VAR1 -gt 0 ]
        then
            break
        fi
    done
    BASE=`basename $entry`
    FILE="s3://cloudcomputingproject2-resized/${BASE}"
    `aws s3 cp ${FILE} ./download/part2-images`
    TIMEEND=$(date +%s)
    FILESIZE=$(stat -f %z "$entry")
    echo "$FILESIZE, `expr $TIMEEND - $TIMESTART`" >> ../data.csv
    `aws s3 rm s3://cloudcomputingproject2-resized/success.text`
done
