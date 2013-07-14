#!/bin/bash

# Convert train/test to VW-able files
python VW/csv2vw.py Data/train.csv VW/Data/train.vw
python VW/csv2vw.py Data/test.csv VW/Data/test.vw

# Train
vw -d Data/train.vw -c -k -f model --loss_function logistic --passes 1
# Test, output to p.txt
vw -t -d Data/test.vw -i model -p p.txt

# Convert VW output to submission standard
python VW/vw2sub.py p.txt Submissions/vw_sub.txt

# Remove the remains
rm p.txt
rm model