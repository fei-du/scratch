BEGIN {
    RS="\nStation No. "
    FS="\n"
    }
{ print $1 }

BEGIN {
    RS="\nStation No. "
    FS="\n"
    station_name = ARGV[1]
    delete ARGV[1]
    }
{
    match($1, /:(.*),(.*)/, stnmatch)
    gsub(/ +/, " ", stnmatch[1])
    gsub(/ +/, " ", stnmatch[2])
    if (tolower(stnmatch[1]) ~ station_name){
	print $1
	for(i=4; i<23; i++){
	    print $i
	    }
	}
    }
