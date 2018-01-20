#!/bin/bash
echo "User info for userid: $USER"
echo UID: $UID
echo home: $HOME

echo "this cost of item is \$15"

days=5
guest="Jessica"
echo $guest checked in $days days ago

# testing=`date`
testing=$(date)
echo testing is: $testing

# today=$(date +%y%m%d)
# ls /usr/bin -al > log.$today
a=100
b=45
var1=$(echo "scale=4; $a/$b" | bc)
echo The answer is $var1

var1=10.46
var2=43.67
var3=33.2
var4=71

var5=$(bc << EOF
scale=4
a1 = ( $var1 * $var2)
b1 = ( $var3 * $var4)
a1 + b1
EOF
)

echo the final answer for this mess is $var5


if pwd ; then
    echo "It worked"
fi


if iamnotacommand ; then
    echo it worked
fi

echo we are outside of the if statement

testUser=dufei

if grep $testUser /etc/passwd ; then
    echo this is my first command
    ls -a /home/dufei/.b*
fi


case $USER in
    dufei)
	echo "welcome, $USER";;


    *)
	echo "you are not allowed";;

esac    # --- end of case ---


for test in  albama alskl denny du; do
    echo the next state is $test
done

if ls ; then
    echo show current working directory
    pwd
fi


for file in /home/dufei/.b* /home/dufei/badtest; do
    if [ -d "$file" ] ; then
	echo "$file is a directory"
    elif [ -f "$file" ]; then
	echo "$file is a file"
    else
	echo "$file doesn't exists"
    fi
done


input="users.csv"
while IFS=',' read -r userid name
do
    echo -----------
    echo "adding $userid"
    echo "adding $name"
done < "$input"
