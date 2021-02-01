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

function show-ssh-keys () {
 # show-ssh-keys shows the ssh keys. Follows symlinks, as suggested by @darkflib
 # Only need the keys' contents? Filenames are written to stderr, so use "show-ssh-keys 2>/dev/null"

 for f in $(find $HOME/.ssh/ -type f,l -iname 'id_*.pub'); do
  echo -e $COLOR_YELLOW 1>&2;
  echo $f 1>&2;
  echo -e $COLOR_LIGHT_BLUE 1>&2;
  cat $f;
  echo -e $COLOR_NONE 1>&2;
 done
 return 0;
}
