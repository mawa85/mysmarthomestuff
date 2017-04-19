#!/bin/bash
##
##requirements: knxd with groupwrite
##
##Input parameters:
## $1 IP of knx gateway
## $2 Group Address DPT 10.001 

DW=$(date +%u)
HH=$(date +%H)
MM=$(date +%M)
SS=$(date +%S)

#Sunday mapping: Linux=0 KNX=7
if [ $DW = 0 ]; then
   DW=7
fi

tmp1=$((($DW*32)+$HH))

p1=`echo "obase=16; $tmp1" | bc`
p2=`echo "obase=16; $MM" | bc`
p3=`echo "obase=16; $SS" | bc`

eval "knxtool groupwrite ip:$1 $2 $p1 $p2 $p3"
