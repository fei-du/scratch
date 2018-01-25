#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error

    # h copy pattern space to hold space
    # H append pattern space to hold space
    # g copy hold space to pattern space
    # G append hold space to pattern space
    # x exchanges
    # b branching: if label is not present, the b command proceeds to the end
    # t if the s command succeessfully matches, the t branches to a label, if label is not present, it branches to the end.
    # & the ampersand symbol is used to represent the matching pattern in s command
    # grouping substring: using parentheses in s command, use the escape character to identify them as grouping characters
    sed '/header/{n ; d}' data1.txt
    sed '/header/{n ; d}' data1.txt  | tail -n 4
    sed '/first/{N ; s/\n/ /}' data2.txt
    sed 'N ; s/system Administrator/Desktop User/' data2.txt
    sed 'N ; s/system.Administrator/Desktop User/' data2.txt
    sed 'N; /system\nAdm/d' data2.txt
    sed 'N; /system\nAdm/D' data2.txt
    sed -n 'N ; /system\nAdmi/P' data2.txt
    sed -n '/first/ { h; p; n; p; g; p}' data2.txt
    sed -n '{1!G; h; $p}' data2.txt
    sed '{2,3b ; s/this is/Is this/ ; s/line/test?/}' data2.txt
    sed '{/first/b jump1; s/this is the/No jump on/
	:jump1
	s/this is the/Jump here on/}' data2.txt
    echo "this, is, a, test, to, remove, commas." | sed -n '{:start
	s/,//1p
	/,/b start
    }'
    sed '{
	s/first/matched/
	t
	s/this is the/No match on/
    }' data2.txt
    echo "this, is, a, test, to, remove, commas." | sed -n '{:start
	s/,//1p
	t start
    }'
    echo "ths cat sleeps in his hat." | sed 's/.at/"&"/g'
    echo "that furry cat is pretty" | sed 's/furry \(.at\)/\1/'
    echo "that furry hat is pretty" | sed 's/furry \(.at\)/\1/'
    # using substring components to insert a comma in long numbers
    echo "45657612345asd1234567" | sed '{
	:start
	s/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/
	t start
    }'
