#!/bin/bash -
#===============================================================================
#
#          FILE: getopts.sh
#
#         USAGE: ./getopts.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月14日 08时30分56秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

echo


while getopts :ab:cd opt ; do

    case "$opt" in
	a)
	    echo "found -a "    ;;

	b)
	    echo "found -b with value $OPTARG"   ;;

	c)
	    echo found -c option ;;
	d)
	    echo found -d option ;;
	*)
	    echo unkonw option: $opt ;;

    esac    # --- end of case ---
done

shift $[ $OPTIND -1 ]
echo
count=1

for param in "$@" ; do
    echo "parameter $count: $param"
    count=$[ $count + 1 ]
done
