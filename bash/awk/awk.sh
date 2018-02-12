#!/bin/bash
# awk pattern action file
awk '//{print $2, $3}' my_shopping.list
# c style printf
awk '//{printf "%-10s %s\n", $2, $3}' my_shopping.list

awk '/ *\$[2-9]\.[0-9][0-9] */ { print $1, $2, $3, $4, "*" ; } / *\$[0-1]\.[0-9][0-9] */ { print ; }' food_prices.list

# awk comparisons
# expression { actions; }  expression { actions; }

awk '$3 <= 15 {printf "%s\t%s\n", $0, "**"; } $3 > 15 {print $0;}' food_prices.list

# awk compound expressions
awk '($3 ~ /^\$[2-9][0-9]\.[0-9][0-9]$/) && ($4=="Tech") { printf "%s\t%s\n", $0, "*"; }' tecmint_deals.txt

# the next command helps you to prevent executing time-wasting stes in a command execution, skipping remaining patterns and expressions, but instead read the next input line.
awk '$3 <= 15 { printf "%s\t%s\n", $0, "*"; next ;} $3 > 15 { print $0;}' food_prices.list

# variables
awk '/bara/ { first_name=$2; gender=$3; print first_name, gender}' names.txt
uname -a | awk '{ hostname=$2; print hostname} '

# count the number of times the domain tecmint.com appears.
awk '/^tecmint.com/ { counter=counter+1; printf "%s\n", counter ;}' domains.txt

awk '/^tecmint.com/ { counter+=1; printf "%s\n", counter ;}' domains.txt

awk ' BEGIN { print "the number of times tecmint appears in the file is: "}
/^tecmint.com/ { counter+=1 ;}
END { printf "%s\n", counter ;}
' domains.txt

# builtin variables

awk '{ print FILENAME}' domains.txt

awk 'END { print "number of records in file is : ", NR }' domains.txt

awk '{print "record:", NR, "has", NF, "fields" ;}' names.txt

awk -F: '{print $1, $4 ; }'  /etc/passwd

awk ' BEGIN { FS=":" ;}
{print $1, $4, $6 ;}
' /etc/passwd

awk ' BEGIN { FS=":";  OFS="==>";}
{print $1, $4 ;}
' /etc/passwd

# using shell quoting
read -p "please enter username:" username
cat /etc/passwd | awk "/$username/"'{ print $0}'

# using variable assignment
username="dufei"
cat /etc/passwd | awk -v name="$username" '$0 ~ name { print $0 }'

# using flow control statement
awk '{
if ( $3 <= 25 ){
    print "User", $1, $2, "is less than 25 years old."
}
else {
    print "user", $1, $2, "is more than 25 years old";
}
}' users.txt

awk 'BEGIN { for (counter=0; counter<=10; counter++){ print counter}} '
awk 'BEGIN {
    counter=0;
    while(counter<=10){
	print counter;
	counter++
    }}'
