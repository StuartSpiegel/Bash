#!/usr/bin/env bash
#Global Script variables
network_interface="INSERT INTERFACE ABBREVIATION"

#Run Standard
ifconfig eth0 | grep "inet addr"

#Run with Options
ifconfig $network_interface | grep "inet addr"
