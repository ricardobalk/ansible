#!/bin/bash

function ip-lookup() {
 # ip-lookup performs an IP lookup via ipinfo.io. If jq is installed, it will also give a neat colourful output.

 if [ -z $1 ]; then printf "Usage: %s <IP address>\n" "$0" 1>&2; return 1; fi;
 if [ -z $(which curl) ]; then printf "This function requires curl. Install with sudo apt install -y curl.\n" 1>&2; return 1; fi;
 if [ -z $IPINFO_ACCESS_TOKEN ]; then printf "Missing ipinfo.io access token. Please set \$IPINFO_ACCESS_TOKEN in .env.local.\n" 1>&2; return 1; fi;
 ipaddress=$1
 url=https://ipinfo.io/$ipaddress?token=$IPINFO_ACCESS_TOKEN
 if [ ! -z $(which jq) ]; then curl -s $url | jq '.'; else curl -s $url; fi
}

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

function create-gh-repo () {
# initialises a Git repo with branches and everything.

 gh repo create --confirm --private "ricardobalk/$1" \
 && cd "$1" \
 && printf "# %s" "$1" > README.md \
 && git add --all \
 && git commit -m 'First commit' \
 && git branch -M production \
 && git push -u origin production \
 && for branch in staging testing develop; \
    do \
     git branch "$branch"; \
     git push origin "$branch"; \
    done \
 && git checkout develop \
 && git log --show-signature
}
