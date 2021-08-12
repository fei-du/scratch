#!/bin/bash -
sed 's/ MA/, Massachusetts/' list
sed -e 's/ MA/, Massachusetts/' -e 's/ PA/, Pennysylvania/' list

awk -F, '{print $1 }' list
awk -F, '{print $1; print $2; print $3; }' list

# sed and awk
sed -f nameState list | awk -F, '{print $4}'
sed -f nameState list | awk -F, '{print $4}' | sort | uniq -c

sed -f nameState list | ./byState
