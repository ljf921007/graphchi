#!/bin/sh
# script for merging the output of the rating application into a single sorted file
# Written By Danny Bickson, CMU
if [ $# -ne 1 ]; then
  echo "Usage: $0 <training file name>"
  exit 1
fi
TRAINING=$1

FOUND=0
rm -f *.sorted
for i in `ls $TRAINING.out[0-9]*`1
do
  FOUND=1
  echo "Sorting output file $i"
  sort -r -g -u -k 1,1 -k 3,3 $i > $i.sorted
done

if [ $FOUND -eq 0 ]; then
  echo "Error: No input file found. Run itemcf again!"
  exit
fi

echo "Merging sorted files:"
sort -g -u -k 1,1 -k 3,3r -m *.sorted > $TRAINING.topk.out
if [ $? -ne 0 ]; then
  echo "Error: Failed to merge!"
  exit 1
fi
echo "File written: $TRAINING.topk.out"

rm *.sorted
