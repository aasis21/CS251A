#!/usr/bin/gawk
BEGIN{

}


{
	if(NR==1){
		col=1
		while (col != NF){
			column["USER"] = col
		}
		print column["USER"]

	}
	print $2

}
