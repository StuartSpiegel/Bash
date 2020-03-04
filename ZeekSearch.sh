#!/usr/bin/env bash

#Script Global Variables
search_term="/INSERT SEARCH TERM/"
log_toSearch="NAME OF LOG TO SEARCH ON"

#Give me all the fields in the 10th column with field name tcp
cat conn.log | awk '$10 == "tcp"' | sort | uniq -c | sort

#Give me the 10th column sorted where the column/field = tcp (title = tcp)
cat conn.log | awk '$10 == "tcp"' | awk '{print $10}' | sort | uniq -c | sort

#Formatted conn.log sorted
cat conn.log | less -S | sort -rn | uniq -c | sort -rn

#search on the search term
cat conn.log | grep $search_term

#Give me Everything EXCEPT the search term (negation)
cat conn.log | grep -v $search_term

#Search with Options
cat $log_toSearch | grep $search_term
