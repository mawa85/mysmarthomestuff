#!/bin/bash

DW=$(date +%u)
HH=$(date +%H)
MM=$(date +%M)
SS=$(date +%S)

p1=$((($DW*32)+$HH))

p1=`echo "obase=16; $p1" | bc`
p2=`echo "obase=16; $MM" | bc`
p3=`echo "obase=16; $SS" | bc`

eval "knxtool groupwrite ip:$1 $2 $p1 $p2 $p3"
