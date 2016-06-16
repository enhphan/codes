#!/bin/bash
#
# Usage:
# ./make_rxp.s junction_length

echo $1
l=`echo '1+8+6+'$1'+6+8+1' | bc`
cat h8.rxp l6.rxp j$1.rxp l6.rxp t8.rxp > x.rxp
xx=`echo '16+'$1 | bc`
yy=`echo '16+'$1'+5' | bc`
cat x.in_template | sed -e 's/ xx / '$xx' /g; s/ yy / '$yy' /g' > x.in

