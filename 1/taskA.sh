#!/bin/bash

function target () {
	var=$(ss -lnt | awk 'FNR > 1 {print $4}' | rev | cut -d ':' -f 1 | rev)
        echo "$var"
}

function all() {
	ip_addr=$(ip addr | grep "/24" | awk '{ print $2 }') 
	echo " $ip_addr"
        nmap -sn $ip_addr | grep "for" | awk '{print  $5, $6}' 	
}

if [[ $# -gt 0 ]]; then
	case $1 in
"--all") 
	all
;;
"--target")
         target
;;
*)
       echo "Try: --all or try --target"
esac	
else
	echo "Possible parameters:
	--all : displays the IP addresses and symbolic names of all hosts in the current subnet
	--target: displays a list of open system TCP ports."
fi
