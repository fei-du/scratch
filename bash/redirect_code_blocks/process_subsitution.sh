#!/bin/bash -
while read des what mask iface; do
    echo $des --- $what ---  $mask --- $iface
done < <(route -n)

echo; echo "###########"; echo

# an easier-to-understand equivalent is:
route -n |
while read des what mask iface ; do
    echo $des --- $what ---  $mask --- $iface
done
