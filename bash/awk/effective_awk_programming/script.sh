awk '/li/ {print $0 }' mailList
awk '/li/ {print $1, $NF }' mailList
awk '/li/ { print $2 }' mailList
# regex can also be used in matching expressions. these expressions allow you to specify the string to match against; it need not to be the entire current input record. the two operators '~' and '!~' performs regex comparisons. expressions using these operators can be used as patterns, or in if, while, for and do statement. the following is true if the expression exp matches regexp. exp ~ /regexp/
awk '$1 ~ /J/' inventoryShipped

awk 'BEGIN { RS = "u"}
    {print $0}' mailList

# for this to work, the text in $3 must make sense as a number; the string of characters must be converted to a number for the computer to do arithmetic on it. the number resulting from the substrction is converted back to a string that then becomes field three.
awk '/J/{ nboxes = $3; $3 = $3 -10; print nboxes, $3}' inventoryShipped
# in other words, $0 changes to reflect the altered field. Thus this program prints a copy of the input file, with 10 subtracted from the second field of each line.
awk '{ $2 = $2 - 10; print $0 }' inventoryShipped
# it is also possible to assign contents to fields that are out of range. 
awk '{ $6 = ($5 + $4 + $3 + $2); print $1, $6}' inventoryShipped # $6 represents the total number of parcels shipped for a particular month.
# it is important to note that making an assignment to an existing field changes the value of $0 but does not change the value of NF, even when you assign the empty string to a field
echo a b c d | awk '{ OFS = ":"; $2 = ""; print $0; print NF}'
# the intervening field, $5, is created with an empty value, and NF is updated with the value six.
echo a b c d | awk '{ OFS = ":"; $2 = ""; $6 = "new"; print $0; print NF}'
# decrementing NF throws away the values of the fields after the new value of NF and recomputes $0.
echo a b c d e f | awk '{ print "NF = ", NF; NF = 3; print $0}'
# the moral is to choose your data layout and separator characters carefully to prevent such problems. if the data is not in a from that is easy to process, perhaps you can massage it first with a separate awk program.
# the stripping of leading and trailing whitespace also comes into play whenever $0 is recomputed.
echo ' a b c d' | awk '{ print; $2 = $2; print}'
# the first print statement prints the record as it was read, with leading whitespace intact. the assignment to $2 rebuilds $0 by concatenating $1 through $NF together, separated by the value of OFS. Because the leading whitespace was ignored when finding $1, it is not part of the new $0.
echo ' a b c d' | awk ' BEGIN{ OFS =  ","}
		    { print; $2 = $2; print}'
# making each character a separate field
echo a b | gawk 'BEGIN { FS = "" }
	    {
		for (i = 1; i <= NF; i = i + 1){
		    print "Field", i, "is", $i
		}
	    }'
awk -F: '$5 == ""' /etc/passwd # searches the system password file and prints the entries for users whose full name is not indicated.

# field-spliting summary: when you assign a string constant as the value of FS, it undergoes normal awk string processing. with awk, the assignment 'FS = "\.."', assigns the string ".." to FS (the backslash is stripped). This creates a regex meaning "fields are separated by occurrences of any two characters." if instead you want fields to be separated by a literal period followed by any single character, use 'FS = "\\.."'. the following list summarizes how fields are split, based on the value of FS ( "==" means "is equal to").
FS == " " # fields are separated by runs of whitespace. leading and trailing whitespace are ignored. this is the default.
FS == any other single character # fields are separated by each occurrence of the character. multiple successive occurrences delimit empty fields, as do leading and trailing occurrences. the character can even be a regexp metacharacter; it does not need to be excaped.
FS == regexp # fields are separated by occurrences of characters that match regexp. leading and trailing matches of regexp delimit empty fields.
FS == "" # each individual character in the record becomes a separated field. (this is a common extension; not specified by the POSIX standard).
# The IGNORECASE variable affects field splitting only when the value of FS is a regexp. it has no effect when FS is a single character.
# reading fixed-width data: a table where all the columns are lined up by the use of a variable number of spaces and empty fields are just spaces. Clearly, awk's normal field splitting based on FS does not work will in this case. Althrough a portalbe awk program can use a series of substr() calls on $0, this is awkward and inefficient for a large number of fields.
# The splitting of an input record into fixed-width fields is specified by assigning a string containing space-separated numbers to the built-in variable FIELDWIDTHS. Each number specifies the width of the field, including columns between fields.
BEGIN { FIELDWIDTHS = "9 6 10 6 7 7 35"}
NR > 2 {
    idle = $4
    sub(/^ +/, "", idle) # strip leading spaces
    if ( idle == "")
	idle = 0
    if (idle ~ /:/){
	split(idle, t, ":")
	idle = t[1] * 60 + t[2]
    }
    if ( idle ~ /days/)
	idle *= 24 * 60 * 60

    print $1, $2, idle
}
# assigning a value to FS causes gawk to use FS for field splitting again. Use 'FS = FS' to make this happen, without having to know the current value of FS. In order to tell which kind of field splitting is in effect, use PROCINFO["FS"].
# normally, when using FS, gawk defines the fields as the parts of the record that occur in between each field separator. In other words, FS defines what a field is not, instead of what a field is. However, there are times when you really want to define the fields by what they are, and not by what they are not. The FPAT variable offers a solution for caees like this. the value of FPAT should be a string that provides a regular expression. This regular expression describes the contents of each field.
echo 'Robbins,Arnold,"1234 A Pretty Street, NE",MyTown,MyState,12345-6789,USA' | awk -f FPAT.awk
To recap, gawk provides three independent methods to split input records into fields. the mechanism used is based on which of the three variables -- FS, FIELDWIDTHS, or FPAT -- was last assigned to.

RS == "\n" # records are separated by the newline character. In effect, every line in the datafile is a separate record, including blank lines. This is the default.

RS == any single character # records are separated by each occurrence of the character. Multiple successive occurrences delimit empty records.

RS = "" # records are separated by runs of blank lines. when FS is a single character, then the newline character always serves as a field separator, in addition to whatever value FS may have. Leading and trailing newlines in a file are ignored.

RS == regexp # records are separated by occurrence of characters that matches regexp. Leading and trailing matches of regexp delimit empty records.
# The awk language has a special built-in command called getline that can be used to read input under your explicit control.
# using getline with no arguments: all it does is read the next input record and split it up into fields. This is usefule if you have finished processing the current record, but want to do some special processing on the next record right now.
# using getline into a variable: no other processing is done. this form of getlien allows you to read that line and store it in a variable so that the main read-a-line-and-check-each-rule loop of awk nevers sees it. The following example swaps every two lines of input:
#	cat <<EOF
#	wan
#	tew
#	free
#	phore
#	EOF
#	awk '{
#	    if ((getline tmp) > 0){
#		print tmp
#		print $0
#	    } else {
#		print $0
#	    }
#	}' <<< 'one
#	two
#	three
#	four'

# the getline used in this way sets only the variables NR, FNR, and RT (and, of course, var). the record is not split into fields, so the values of the fields (including $0) and the value of NF do not change.
# the items to print can be constant strings or numbers, fields of the current records, variables, or any awk expression. Numeric values are converted to strings and then printed. print statement is a statement and not an expression.
awk 'BEGIN { OFS = ";"; ORS = "\n\n"}
    {print $1, $2}' mailList
# when printing numeric values with print statement, awk internally converts each number to a string and print that string. awk uses the sprintf() function to do this conversion. the predeined variable OFMT contains the format specification that print uses with sprintf(). the default value of OFMT is "%.6g"
awk 'BEGIN { OFMT = "%.0f"; print 17.23, 17.54}'
# the printf statement does not automatically append a newline to its output. it outputs only what the format string specifies. So if a newline is needed, you must include one in the format string. the output separator OFS and ORS have no effect on printf statements.
awk 'BEGIN {
    msg = "don\47t Panic!"
    printf "%s\n", msg
}'
# the C library printf's dynamic width and prec capability is supported.
awk 'BEGIN {
    w = 5
    p = 3
    s = "abcedf"
    printf "%*.*s\n", w, p, s
}' # is exactly equivalent to:
awk 'BEGIN{
    s = "abcedf"
    printf "%5.3s\n", s
}'
awk ' BEGIN {
    printf "%-10s %s\n", "Name", "number"
    printf "%-10s %s\n", "----", "------"
    }
{printf "%-10s %s\n", $1, $2}' mailList
# the fact that the same format specification is used three times can be emphasized by storing it in a variable:
awk ' BEGIN {
    format = "%-10s %s\n"
    printf format, "Name", "number"
    printf format, "----", "------"
    }
{printf format, $1, $2}' mailList

# redirecting output of printf and print. the filename output can any expression. its value is changed to a string and then used as a filename
# print items > output-file
awk '{print $2 > "phone-list"; print $1 > "name-list"}' mailList
# print items >> output-file
# print items | command # send otuput to another program through a pipe instead of into a file. this redirection opens a pipe to command, and write the values of items through this pipe to another process created to execute command. the argument command is actually an awk expression. its value is converted to a string whose contents give the shell command to be run.
awk '{ print $1 > "names.unsorted"
    command = "sort -r > names.sorted"
    print $1 | command
}' mailList

#clear the file
print "don't panic!" > file
#append
print "avoid improbabitity generators" >> file
# this is indeed how redirections must be used from the shell. but in awk, it isn't necessary. in this kind of case, a program should use '>' for all the print statements, Because the output file is only opened once.
# gawk provide special filenames for accessing the three standard streams. if the filename matches one of these special names when gawk redirects input or output, then it directly uses the descriptor that the filename stands for.
# /dev/stdin
# /dev/stdout
# /dev/stderr
# with these facilities, the proper way to write an error message then becomes:
print "serious error detected" > "/dev/stderr"
# note the use of quotes around the filename. like with any other redirection, the value must be a string.

#closing input and output redirections
# if the same filename or the same shell command is used with getline morethan once during the execution of an awk program, the file is opened the first time only. at that time, the first record of input is read from that file or command. the next time the same file or command is used with getline, another record is read from it, and so on.
# similiar, when a file or pipe is opened for output, awk remembers the filename or command associated with it, and subsequent writes to the same file or command are appended to the previous write. the file or pipe stays open until awk exits.
# this implies that special steps are necessary in order to read the same file again from the beginning, or to rerun a shell command. the close() function makes these things possible. the argument filename or command can be any expression. its value must exactly match the string that was used to open the file or start the command ( spaces and other irrelevant characters included). it is good practice to use a variable to store the filename or commmand: 
sortcom = "sort -r names"
sortcom | getline foo
...
close(sortcom)
# this helps avoid hard-to-find typographical errors in your awk programs. here are some of the reasons for closing an output file:
    # to write a file and read it back later on in the same awk program. close the file after writing it, then begin reading it with getline.
    # to write numerous files, successively, in the same awk program.
    # to make a command finish. often this means the command cannot really do its work until the pipe is closed.
    # to run the same program a second time, with the same arguments.

# expressions
# most regexps used in awk are constant, but the "~" and "!~" matching operators can also match computed or dynamic regexps.
# when a regexp constant appears by itself, it has the same meaning as if it appeared in a pattern. this means the following two code segements are exactly equivalent:
if ($0 ~ /barfly/ || $0 ~ /camelot/ )
    print "found"
# and:
if (/barfly/ || /camelot/)
    print "found"
# another consequence of this rule is that the assignment statement:
matches = /foo/ # assigns either 0 or 1 to the variable matches, depending upon the contents of the current input record.
# gawk issues a warning when it sees a regexp constant used as a parameter to a user-defined function, Because passing a truth value in this way is probably not what was intended.
# by default, variables are initialized to the empty string, which is zero if converted to a number.
# when the assignment is preceded with the -v option, as -v variable=text, the variable is set at the beginning, even before the BEGIN rules execute. otherwise, the variable assignment is performed at a time determined by its position among the input file arguments -- after the processing of the preceding input file argument.
# Because string concatenation does not have an explicit operator, it is often necessary to ensure that it happens at the right time by using parentheses to enclose the items to concatenate.
file = "file"
name = "name"
print "something meaningful" > file name # syntax error
print "something meaningful" > (file name)
# string values that do not begin with a digit have a numeric value of zero.
# awk borrows a very simple concept of true and false from C. in awk, any nonzero numeric value or any nonempty string value is true. any other value ( zero or the null string, "") is false.
# the "&&" and "||" are called short-circuit operators Because of the way they work. Evaluation of the full expression is short-circuited if the result can be determined partway through its evaluation.
# pattern elements
    # / regular expression/
    # expression
	awk '$1 == "li" {print $2}' mailList
	awk '$1 ~ "li" {print $2}' mailList
	# A regexp constant as a pattern is also a special case of an expression pattern.
	awk '/edu/ && /li/' mailList
	awk '/edu/ || /li/' mailList
	awk '! /li/' mailList
	# the subexpressions of a boolean operator in a pattern can be constant regular expressions, comparisons, or any other awk expressions.
    # begpat, endpat a pair of patterns separated by comma, specifying a range of records.
    awk '$1 == "on", $1 == "off"' myfile
	# it is possible for a pattern to be turned on and off by the same record. if the record satisfies both conditions,then the action is executed for just that record. For example, suppose there is text between two identical markers (e.g. '%'), each on its own line, that should be ignored. a first attempt would be to combine a range pattern that describes the delimited text with the next statement. such a program looks like this:
	/^%$/,/^%$/ { next}
		    {print}
	# this program fails Because the range pattern is both turned on and turned off which just has a '%' in it. to accomplish this task, write the program using a flag:
	/^%$/ { skip = !skip; next}
	skip == 1 { next } # skip lines with 'skip' set.
	
    # BEGIN
    # END supply startup or cleanup actions for your awk program
	# an awk program may have multiple BEGIN and/or END rules. they are executed in the order in which they appear: all the BEGIN runs at startup and all the END runs at termination. Multiple BEGIN and END rules are useful for writing library functions, Because each library file can have its own BEGIN and END rule to do its own initialization and cleanup. The order in which library functions are named on the command line controls the order in which their BEGIN and END are executed.
    # BEGINFILE
    # ENDFILE supply startup or cleanup actions to be done on a per-file basis.
    # empty matches every input record.
# using shell variables in programs. two ways:
    # a common method is to use shell quoting to substitute the variable's value into the program inside the script
    printf "enter search pattern: "
    read pattern
    awk "/$pattern/ "'{nmatches++}
	END { print nmatches, "found"}' /path/to/data
    # the awk program consists of two pieces of quoted text that are concatenated together to form the program. the first part is double-quoted, which allows substitution of the pattern shell variable inside the quotes. the second part is single-quoted.
    # a better method is to use awk's variable assignment feature to assign the shell variable's value to an awk variable. then use dynamic regexps to match the pattern.
    printf "enter search pattern: "
    read pattern
    awk -v pat="$pattern" '$0 ~ pat {nmatches++}
	END { print nmatches, "found"}' /path/to/data
    # the assignment  -v still requires double quotes, in case there is whitespace in the value of $pattern. Using a variable provides more flexibility, as the variable can be used anywhere inside the program -- for printing, as an array subscript, or for any other use -- without requiring the quoting tricks at every point in the program
    /foo/ { } # match foo, do nothing --- empty action
    /foo/     # match foo, print the record --- omitted action
    # The next statement forces awk to immediately stop processing the current record and go on to the next record. this means that no further rules are executed for the current record, and the rest of the current rule's action isn't executed. contrast this with the effect of the getline function. that also causes awk to read the next record immediately, but it does not alter the flow of control in any way (the rest of the current action executes with the new input record).
    # For example, suppose awk program works only on records with four fields, and it shouldn't fail when given bad input. to avoid complicating the rest of the program, write a weed out rule near the beginning, in the following manner:
    NF != 4 {
    printf("%s:%d skipped: NF != 4\n", FILENAME, FNR) > "/dev/stderr"
    next
    }
# built-in variables that control awk
    # BINMODE
    # CONVFMT -- a string that contols the conversion of numbers to strings
    # FIELDWIDTHS -- a spaces-separated list of columns that tell gawk how to split input with fixed columnar boundaries.
    # FPAT --  a regular expression that tells awk to create the fields based on text that matches the regexp. assigning a value to FPAT overrides the use of FS and FIELDWIDTHS for field splitting.
    # FS
    # IGNORECASE -- if nonzero or non-null, all string comparisons and regular expression matching are case-independent.
    # OFMT -- a string that controls the conversion of numbers to strings.
    # OFS
    # ORS
    # RS
# built-in variables that convey info.
    # ARGC, ARGV -- the command-line arguments available to awk programs are stored in an array called ARGV. ARGC is the number of command-line arguments present.
    # ARGIND --  the index in ARGV of the current file being processed.
    # FILENAME -- the name of current input file
    # FNR -- the current record number in the current file
    # NF -- number of fields in the current input record
    # NR -- number of input records awk has processed since the beginning of the program's execution.
    # RLENGTH -- the length of the substring matched by the match() function. it is set by invoking the match() function.
    # RSTART -- the start index in characters of the substring that is matched by the match() function.
    # RT -- the input text that matched the text donoted by RS.
# string manipulation functions
    # gensub(regexp, replacement, how [, target]): the ability to specify components of a regexp in the replacement text.
    gawk '
	BEGIN {
	a = "abc def"
	b = gensub(/(.+) (.+)/, "\\2 \\1", "g", a) 
	print b
    }
    ' # as with sub(), you must type two backslashes in order to get one into the string.
    echo a b c a b c |
    gawk '{print gensub(/a/, "AA", 2)}' # in this case, $0 is the default target string. gensub() returns the new string as its result. if regexp does not match target, gensub()'s return value is the original unchanged value of target.
    # there is no need to put the definition of a function before all uses of the function. this is because awk reads the entire program before starting to execute any of it.
    # controling variable scope To make a variable local to a function, simply declare the variable as an argument after the actual arguments. the extra space before i is a coding convention to indicate that i is a local variable, not an argument.
    function bar(    i)
    {
	for (i = 0; i < 3; i++)
	    print "bar's i=" i
    }
    function foo(j,   i)
    {
	i = j + 1
	print "foo's i=" i
	bar()
    }
