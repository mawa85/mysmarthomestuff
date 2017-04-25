#!/bin/bash
##this script updates datetime s sson internet is available and sends the current timeto knx bus
##requirements: knxd with groupwrite, internet access
##
##Input parameters:
## $1 IP of knx gateway
## $2 Group Address DPT 10.001 

while true; do ping -c1 www.google.com > /dev/null && break; done

ntpd -g

DW=$(date +%u)
HH=$(date +%H)
MM=$(date +%M)
SS=$(date +%S)

HH=$((10#$HH))
MM=$((10#$MM))
SS=$((10#$SS))


#Sunday mapping: Linux=0 KNX=7
if [ $DW = 0 ]; then
   DW=7
fi

tmp1=$((($DW*32)+$HH))

p1=`echo "obase=16; $tmp1" | bc`
p2=`echo "obase=16; $MM" | bc`
p3=`echo "obase=16; $SS" | bc`

eval "knxtool groupwrite ip:$1 $2 $p1 $p2 $p3"
