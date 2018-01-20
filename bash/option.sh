#!/bin/bash -
#===============================================================================
#
#          FILE: option.sh
#
#         USAGE: ./option.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月13日 22时18分41秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

set -- $(getopt -q ab:cd "$@")

echo

while [ -n "$1" ] ; do

    case "$1" in
	-a)
	    echo "found the -a option"    ;;

	-b) param="$2"
	    echo found the -b, with parammer value $param
	    shift ;;
	-c)echo "found the -c option" ;;
	--) shift
	    break;;
	*) echo "$1 is not an option"
	    ;;

    esac    # --- end of case ---
    shift
done

count=1

for param in "$@" ; do
    echo "parameter #$count: $param"
    count=$[ $count + 1 ]
done
