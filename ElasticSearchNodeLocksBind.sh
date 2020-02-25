#!/usr/bin/env bash

#Script Global Vars
PID_TO_KILL="INSERT PID"

#Identify instances of Java currently running
ps aux | grep 'java'

#Kill the Process ID (PID) of instance
kill -9 $PID_TO_KILL
