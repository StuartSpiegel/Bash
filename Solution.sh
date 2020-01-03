#There are (N) integers in an array (A) . All but one integer occur in pairs.
#Your task is to find the number that occurs only once.
#Input Format
#-----------------------------
#The first line of the input contains an integer ,
#indicating the number of integers. The next line contains  space-separated
#integers that form the array .
#----------------------------
#Constraints
# 1 <= N <= 100
# (N % 2) = 1 (N is odd.)
# 0 <= A[i] <= 100, FOR-ALL [1, N].
#-------------------------------
# Output (S) the number that occurs only once in the array (A).
# Author: Stuart Spiegel
# Date: 1/1/2020
#--------------------------------
#/bin/bash

NumParams=$#~
ParamVals=$@

read numNumbers
read -a numbers

num=0

for element in ${numbers[*]}
do
  num=$(($num ^ element))
done

echo $num

exit 0
