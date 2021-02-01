#!/bin/bash

function lan-scan () {
 # lan-scan performs a scan with nmap to show which hosts are in your LAN.
 # it uses 192.168.0.0/24 by default, but can be changed by passing an argument, or by changing the code.

 default="192.168.0.0/24"
 if [ -z $1 ];
   then
     printf "Usage: lan-scan [ip address/netmask]. Using default value %s.\n" "$default" 1>&2;
     addr="$default";
   else
     addr="$1";
   fi
  nmap -sn "$addr"
}
