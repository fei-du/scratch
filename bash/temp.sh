#!/bin/bash -
#===============================================================================
#
#          FILE: temp.sh
#
#         USAGE: ./temp.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月14日 10时45分19秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

tempfile=$(mktemp test19.XXXX)
exec 3>$tempfile

echo this script writes to temp file $tempfile

echo "firsr line" >&3
echo "second line" >&3
echo "third line" >&3

exec 3>&-

echo "Done creating temp file, content is:"

cat $tempfile
rm -f $tempfile 2> /dev/null

testUser=dufei

if grep $testUser /etc/passwd ; then
    echo 'founded'
    echo 'founded'
    ls $HOME
fi

array=(zeor one two three "four and beyond")
declare -p array
echo ${!array[@]}
array=( "${array[@]:2:3}" )
declare -p array

IFS.OLD=$IFS
IFS=$'\n'
for entry in $(cat /etc/passwd)
do
    echo "values in $entry -"
    IFS=:
    for value in $entry
    do
	echo "   $value"
    done
done | less

for state in "North Dakota" Connecticut Illinois Alabama Tennessee
do
    echo "$state is the next place to go"
done | sort
echo This completes our travels


input="users.csv"
while IFS=',' read -r userid name
do
    echo "adding $userid name is $name"
done < "$input"

case "$-" in
    *i*)
	echo code for interactive shell
	;;
    *)
	echo code for non-interactive
	;;
esac
