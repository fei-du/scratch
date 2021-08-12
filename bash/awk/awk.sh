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
awk '{ if(NR ~/^2$/) print }' story.txt # would print line 2 from story.txt file
awk '{ if(NR ~ 2) print }' story.txt # would print any line containing the number 2
awk '{ if(NR !~ 2) print }' story.txt # would print any line containing the number 2
ls *.sh # could be written using awk ...
ls -l | awk '/.sh/'
ls -l | awk '/.sh|/py/'
ifconfig wlan0 | awk '{if(NR==2) print $2}' | awk 'BEGIN{FS=":"}{print $2}'
awk 'if(toupper($3) == 'HELLO'){ system("/home/hello/world/helloworld.sh")}' somefile.txt

awk -F":" '{ print $1}' /etc/passwd
awk -F":" '{ print $1 $3}' /etc/passwd
awk -F":" '{ print "username: "  $1 "\t\t\tuid: " $3}' /etc/passwd | head
awk -F":" ' $5 ~ /root/ { print $1  "  " $3}' /etc/passwd
# awk also allows the use of boolean operator || and && to allow the creation of more complex boolean expressions
( $1 == "foo" ) && ( $2 == "bar" ) { print }
# stringy variables: one of the neat things about awk variables is that they are "simple and stringy". because all awk variables are stored internally as strings. at the same time, awk variables are simple because you can perform mathematical operation on a variable, and as long as it contains a valid numeric string, awk automatically take care of the string-to-number conversion steps. if a particular variable doesn't contain a valid number, awk will treat that variable as a numeric zero when it evaluates your mathematical expression.
# if you processing fields separated by one or more tabs, FS="\t+"
FS = "foo[0-9][0-9][0-9]"
(NR < 10 ) || ( NR > 100 ) { print "we are on record number 1-9 or 101+"}
{
    # skip header
    if ( NR > 10 ){
	print "ok, now for the real information"
    }
}

BEGIN{
    FS="\n"
    RS=""
}
{
    print $1 ", " $2 ", " $3
}

BEGIN {
    FS="\n"
    RS=""
    ORS="" # which will cause the print statement to not output a newline at the end of each call. This means that if we want any text to start on a new line, we need to explicitly write print "\n"
}
{
    x=1
    while ( x < NF ){
	print $x "\t"
	x++
    }
    print $NF "\n"
}

# iterating over arrays
# when you use this special "in" form of a for loop, awk will assign every existing index of myarray to x in turn. it does have one drawback,-- when awk cycles through the array indices, it doesn't follow any paritcular order. this has to do with the stringiness of awk arrays.
for ( x in myarray ) { 
    print myarray[x]
}
myarr["name"]="Mr. Whipple"
print myarr["name"]
# awk doesn't limit us to using pure integer indexes; we can use string indexes if we want to. whenever we use non-integer array indices, we're using associative arrays. the stringy index thing will be our little secret.:)
# we aren't required to have a continuous numeric sequence of indices ( for example, we can define myarr[1], any myarr[100], but leave all other elements undefined)
# delete array elements
delete fooarray[1]
# if you want to see if a paritcular array element exists, you use
if ( 1 in fooarray ) {
    print "ayep! it's there."
}
# in awk, you can't treat a string as an array of characters
awk 'BEGIN{
    mystring="How are you doing today?"
    print length(mystring)
    print index(mystring, "you")
    print tolower(mystring)
    print toupper(mystring)
    print substr(mystring, 9, 3)
    # the match() function will return the starting position of the match, or zero if no match. in addition it will set two variables called RSTART and RLENGTH
    print match(mystring, /you/), RSTART, RLENGTH
    # string substitution sub() and gsub(). these guys differ slightly. they actually modify the original string.
    sub(/o/, "O", mystring ); print mystring
    mystring="How are you doing today?" # we had to reset mystring to its original value, because sub() call modified
    gsub(/o/, "O", mystring ); print mystring
    # split return the number of string elements that were split
    numelements=split("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",mymonths,",")
    print mymonths[1],mymonths[numelements]

}'
# A quick note -- when calling length(), sub(), gsub(), you can drop the last argument and awk will apply the function call to $0. To print the length of each line in a file, use this awk script: {print length()}

# name, marks,max marks
# user1,200,1000
# user2,500,1000
# user3,1000
# user4,800,1000
# user5,600,1000
# user1,400,1000
echo "abcd" | awk -F "" '{ print $2 $1 }'
awk -F, '{a[$1]+=$2;} END{for(i in a) print i","a[i]}' example-file
awk -F, '{x+=$2; y+=$3; print} END{ print "total,"x,y}' example-file
awk -F, '!a[$1]++' example-file  # only show the first it appears
awk -F, '{a[$1]++;}END{for(i in a) print i,a[i];}' example-file # calculate the freqency
# summary IP address log
BEGIN {
print "log access to web server"
}
{ip[$1]++}
END{
for (i in ip)
    print i, " has accessed ", ip[i], " times"
}
grep -c '192.168.0.58'
# using awk count login shell times
awk -F: '{user_shell[$7] +=1;} END{ for (i in user_shell) print i " happens " user_shell[i]}' /etc/passwd

# find common lines in two files
awk '
    FNR == NR {
    arr[$1]
    next  # continue to read until finishing reading all lines of first file
}
    $1 in arr{
    print $1, "in both files"
}
' a.txt b.txt
# TRUE: non-empty string or non-zero number
# FALSE: empty string or number with value zero
awk '
    BEGIN{
	if (a){
	    print "1. a true found"
	} else {
	    print "1. a false found"
	}
    }
'
# awk array primer
a[0] = "Tabitha Gallagher" # store a value by numeric index
u['tgllagher']= "Tabitha Gallagher" # store a value by text key
conns['10.0.0.2 66.8.54.3'] = 203 # complex key made of IPs
u['ishort']['name'] = "Ira Short" # multi-dimension array
length(u) # get the numbers of keys in the a array
