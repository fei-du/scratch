#!/usr/bin/awk -f
BEGIN { FS=":"}
/dufei/ { print "username", $1, "user ID:", $3 ;}
