#!/bin/bash -
var1=10.46
var2=43.67
var3=33.2
var4=71

var5=$(bc <<EOF
scale = 4
a1 = ($var1 * $var2)
b1 = ($var3 * $var4)
# any variable created within bc are valid only within bc
a1 + b1
EOF
)

echo the final is $var5
