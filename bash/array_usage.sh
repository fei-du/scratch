#!/bin/bash -
# array members need not to be consecutive or contiguous
area[11]=23
area[13]=37
area[51]=UFOs

echo -n "area[11] = "
echo ${area[11]}

echo "contents of area[51] are ${area[51]}"

echo -n "area[43] = "
echo ${area[43]}
echo "(area[43] unassigned)"

# another way of assigning array variables...
area2=( zero one two three four )
echo -n "area2[0] = "
echo ${area2[0]}

# yet another way of assigning array variables...
area3=([17]=seventeen [24]=twenty-four)

echo -n "area3[24] = "
echo ${area3[24]}

base64_charset=( {A..Z} {a..z} {0..9} + / = )
echo ${base64_charset[*]}

# bash permits array opreations on variables, even if the variables are not explicitly declared as arrays.
# bash variables are untyped.
string=abcABC123
echo ${string[@]}
echo ${string[*]}
echo ${string[0]}
echo ${string[1]}
echo ${#string[@]} # one element in the array the string itself

# various array operations
# many of the standard string operations work on arrays
array=( zero one two three four five )
echo ${array[0]}
echo ${array:0} # parameter expansion of first element starting at position # 0
echo ${array:1} # parameter expansion starting # 1
echo "-----------"
echo ${#array[0]} # length of first element of array
echo ${#array}
echo ${#array[1]} # length of second element of array
echo ${#array[*]} # number of elements in array
echo ${#array[@]} # number of elements in array
# quoting permits embedding whitespace within individual array elements
array2=( [0]="first elements" [1]="second element" [3]="fourth element"  )
echo ${array2[0]}
echo ${array2[2]}
echo ${#array2[0]}
echo ${#array2[*]}

# string operation on arrays
# in general, any string operation using the ${name ...} notation can be applied to all string elements in an array with the ${name[@] ... } or ${name[*] ...} notation
array=( zero one two three four five )
echo ${array[@]:0} # all elements
echo ${array[@]:1} # all elements following element[0]
echo ${array[@]:1:2} # only the two after element[0]
echo "----------"
# substing removal
array=( zero one two three four five atthhrase )
echo ${array[@]#f*r} # applied to all elements of the array. Matches "four" and removes it.
# longest match from front of string
echo ${array[@]##t*e} # Matches "three" and remove it.
# shortest match from back of string
echo ${array[@]%h*e} # matches "h*e" and removes it.
# longest match from back of strings
echo ${array[@]%%t*e}
echo "----------"
# substring replacement
array=( zero one two three four fiveive atthhrase five fifive )
echo ${array[@]}
# replace first occurence of substring
echo ${array[@]/iv/XY}
# replace all occurence of substring
echo ${array[@]//iv/XY}
# delete all occurence of substring
# not specifing a replacement defaults to "delete"
echo ${array[@]//iv/}
echo ${array[@]//fi/}
# replace front-end occurence of substring
echo ${array[@]/#fi/XY}
# replace back-end occurence of substring
echo ${array[@]/%ve/ZZ}
echo ${array[@]/%o/XX}
echo "-------------"
replacement(){
    echo -n "!!!"
}
echo ${array[@]/%e/$(replacement)}
echo ${array[@]//*/$(replacement optional)}
# before reaching for big hammer -- perl python-- recall:
# $(...) is command subsitution
# a function runs as a sub-process
# a function writes its output (if echo-ed) to stdout
# assignment, in conjunction with "echo" and command subsitution can read a function's stdout
# command subsitution can construct the individual elements of an array.
# loading the contents of a file into an array
script_contents=($(cat a.sh))
echo ${script_contents[@]}

for element in $(seq 0 $((${#script_contents[@]} - 1 ))) ; do
    echo -n "${script_contents[$element]}"
    # echo -n "${script_contents[element]}" # also works because of ${ ... }
    echo -n " -- "
    echo
done

# of empty arrays and empty elements
# an empty array is not the same as an array with empty elements
array0=( first second third )
array1=( "" ) # consisting of one empty element
array2=( ) # no elements
array3=(  )
echo
ListArray(){
    echo
    echo "elements in array0: ${array0[@]}"
    echo "elements in array1: ${array1[@]}"
    echo "elements in array2: ${array2[@]}"
    echo "elements in array3: ${array3[@]}"
    echo
    echo "length of first element in array0 = ${#array0}"
    echo "length of first element in array1 = ${#array1}"
    echo "length of first element in array2 = ${#array2}"
    echo "length of first element in array3 = ${#array3}"
    echo
    echo "number of elements in array0 = ${#array0[@]}"
    echo "number of elements in array1 = ${#array1[@]}" # 1 (surprise!)
    echo "number of elements in array2 = ${#array2[@]}"
    echo "number of elements in array3 = ${#array3[@]}"
}
# try extending those arrays
array0=( "${array0[@]}" "new1" )
array1=( "${array1[@]}" "new1" )
array2=( "${array2[@]}" "new1" )
array3=( "${array3[@]}" "new1" )
# or
array0[${#array0[*]}]="new2"
array1[${#array1[*]}]="new2"
array2[${#array2[*]}]="new2"
array3[${#array3[*]}]="new2"
# when extended as above, arrays are stacks ... Above is the push
# the pop is
unset array2[${#array2[@]}-1]
echo popping
echo "elements in array2: ${array2[@]}"
ListArray
# the relationship of ${array_name[@]} and ${array_name[*]} is analogous to that $@ and $*. This powerful array notation has a number of uses.
