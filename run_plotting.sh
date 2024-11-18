#!/bin/bash

mkdir -p $BASEDIR/$REGION/processed

for file in `ls $BASEDIR/$REGION/out/wrfout_d01*`
do
   file1=`echo $file | sed 's/d01/d02/'`
   echo $file
   time (python3 $BASEDIR/plots/post_process.py $file & (sleep $[ ( $RANDOM % 5 ) + 1 ] && python3 $BASEDIR/plots/post_process.py $file1))
   # mv $file $BASEDIR/$REGION/processed/
done
