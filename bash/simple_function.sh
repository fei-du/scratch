#!/bin/bash -
JUST_A_SECOND=1

funky () {
    echo "this is a funky function"
    echo "now exiting funky function"
}

fun(){
    i=0
    REPEATS=4
    echo
    echo "And now the fun really begins."
    echo
    
    sleep $JUST_A_SECOND
    while [ $i -lt $REPEATS ]  ; do
	echo "---------functions-------"
	echo "---------ARE-------------"
	echo "---------Fun-------------"
	echo
	let "i+=1"
    done
}

funky

fun

DEFAULT=default

func2(){

    if [ -z "$1" ] ; then
	echo "$1 is zero length. -"
    else
	echo "-Parameter #1 is \"$1\".- "
    fi

    variable=${1-$DEFAULT}
    echo "variable = $variable"
    
    if [ "$2" ] ; then
	echo "-Parameter #2 is $2"
    fi

    return 0
}
echo
echo "nothing passed"
func2
echo

echo
echo "zero-length parameter passed"
func2 ""
echo
echo
echo "one parameter passed"
func2 first
echo
echo
echo "tow parameter passed"
func2 first second
echo

echo
echo "zero-lenght first parameter and second one"
func2 "" second
echo
