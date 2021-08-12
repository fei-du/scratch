#!/bin/bash -
echo

echo "random input" | while read i
do
    global=3D":not available outside the loop"
done

echo "\$global from the outside the subprocess = $global"
echo; echo "--"; echo;


while read i ; do
    echo $i
    global=3D":available outside the loop"
done < <(echo "random input")

echo
echo "\$global (using process substituion)= $global"
echo; echo "#######"; echo;
