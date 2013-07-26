#!/bin/bash

# Convert train/test to VW-able files
python VW/csv2vw.py Data/train.csv Data/train.vw
python VW/csv2vw.py Data/test.csv Data/test.vw

# Train
vw -d Data/train.vw -k -c -f Data/model --loss_function logistic -b 25 --passes 20 -q ee --l2 0.0000005
# Test, output to p.txt
vw -t -d Data/test.vw -i Data/model -p p.txt

# Convert VW output to submission standard
python VW/vw2sub.py p.txt Submissions/vw_sub_quadratic.txt

# Remove the remains
#rm p.txt
#rm Data/model