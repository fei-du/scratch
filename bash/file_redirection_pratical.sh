#!/bin/bash -
#===============================================================================
#
#          FILE: file_redirection_pratical.sh
#
#         USAGE: ./file_redirection_pratical.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月14日 10时58分54秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
outfile="members.sql"
IFS=','
while read lname fname address city state zip
do
    cat >> $outfile << EOF
    INSERT INTO members (lname, fname, address, city, state, zip) values
    ('$lname', '$fname', '$address', '$city', '$state', '$zip');
EOF
done < ${1}
