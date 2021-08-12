#!/bin/bash -

echo_var(){
    echo "$1"
}

message=Hello
Hello=Goodbye

echo_var "$message" #Hello

# now, let's pass an indirect reference to the function
echo_var "${!message}" # Goodbye

echo "-----------"

# what happens if we change the contents of "hello" variable?
Hello="Hello, again!"

echo_var "$message" #Hello
echo_var "${!message}"  # Hello, again!


# Test large return values in a function
# the largest positive ineger a function can return is 255.

return_test(){
    return $1
}

return_test 27
echo $?

return_test 255
echo $?
return_test 257
echo $?

# a more elegant method is to have function echo its "return value to stdout" and then capture is by command subsitution

month_length(){
    monthD="31 28 31 30 31 30 31 31 30 31 30 31"
    echo "$monthD" | awk '{ print $'"${1}"' }'
    # template for  passing a parameter to embedded awk script:
	# $'"${script_parameter}"'
    # here's a slighty simpler awk construct:
    # echo $monthD | awk -v month=$1 '{print $(month)}'
    # uses the -v awk option, which assigns a variable value prior to execution of the awk program block.
}

month=3
days_in=$(month_length $month)
echo $days_in
