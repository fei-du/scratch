#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error

var="the txt hello world"


if echo "$var" | grep -q txt ; then
    echo "$var contains the substring sequence \"txt\" "
fi


if grep -q "txt" <<< "$var" ; then
    echo "$var contains the substring sequence \"txt\" "
fi

String="this is a string of words"

read -r -a Words <<< "$String"
# the -a option to "read" assigns the results values to successive member of an array

echo "First word in String is: ${Words[0]}"
echo "Second word in String is: ${Words[1]}"
echo "Third word in String is: ${Words[2]}"
echo "Fourth word in String is: ${Words[3]}"

# possible to feed the output of a here string into stdin of a loop
ArrayVar=( element0 element1 element2 {A..D} )


while read element ; do
    echo "$element" 1>&2
done <<< $(echo ${ArrayVar[*]})

# there remain descriptors 3 to 9. It is sometimes useful to assgin one of these additional file descriptors to stdin, stdout, or stderr as a temporary duplicate link. this simplifies restoration to normal after complex redirection and reshuffling.


# redirecting stdin using exec
# redirects stdin to a file. from that point on, all stdin comes from that file. this provides a method of reading a file line by line and possibly parsing each line of input using sed and/or awk
exec <filename

exec 6<&0

exec < file.txt

read
read a1
read a2

echo
echo "Following lines read from file"
echo "------------------------------"
echo $a1
echo $a2
echo; echo; echo;
exec 0<&6 6<&-

# redirecting stdout using exec
LOGFILE=logfile.txt

exec 6>&1 # line #6 with stdout

exec > $LOGFILE

# all output from commands sent to file $LOGFILE

echo -n "Logfile: "
date
echo "----------------------"

echo "output of  ls -al command"
echo
ls -al
echo; echo
echo "----------------------"

exec 1>&6 6>&-  # restore stdout and close #6
echo
echo "== stdout now restored to default =="
echo
ls -al
echo
