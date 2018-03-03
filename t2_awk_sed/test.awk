#!/usr/bin/gawk

BEGIN{
        comment=0
        multiple_line=0
        string = 0
        string_count=0
        string=0
        }
{

print "\n"
print $0
print  "\n"
}

{
    if(multiple_line==1){
        print multiple_line
        line=split($0,ran,"\n")
        print line "---ghgh"
        comment = comment + line
        multiple_line = 0
        print "-----------------------------------"
        RS=/\n/
        next


    }

    if(multiple_line==1 && string==0 && ($0 ~ /^.*\*\/.*$/)) {
        comment ++
        multiple_line=0
    }

    if(multiple_line==0 && single_line==0 && string==0 && ( $0 ~ /^.*\/\*.*$/)){
        multiple_line = 1
        comment++
        RS = /^\*\/$/
        FS="\n"
        next
    }

    if(multiple_line==0 && string==0 && ( $0 ~ /^.*\*\/.*\/\/.*$/)){
        single_line = 1
        comment++
        }
}

{
    single_line = 0
    #print single_line "," multiple_line "," comment
}

END{
    print comment
}





END{

    for(i in final_time) {
        if(flag2[i] != 1){
            split(i, ip, "+")

            split(ip[1], ip1, ".")
            ip1_with_colon = ip1[1]"."ip1[2]"."ip1[3]"."ip1[4]":"ip1[5]

            split(ip[2], ip2, ".")
            ip2_with_colon = ip2[1]"."ip2[2]"."ip2[3]"."ip2[4]":"ip2[5]

            printf "Connection (A=%s B=%s)\n",ip1_with_colon,ip2_with_colon
            k=ip[1]"+"ip[2]

            split(final_time[k], f, ":")
            final = f[1]*3600 + f[2]*60 + f[3]

            split(starting_time[k], s, ":")
            initial = s[1]*3600 + s[2]*60 + s[3]

            total_time = final - initial

            throughput = int(no_of_bytes[k]/total_time)

            printf "A-->B #packets=%d, #datapackets=%d, #bytes=%s, xput=%d bytes/sec\n",no_of_packets[k],no_of_data_packets[k],no_of_bytes[k],throughput


            l=ip[2]"+"ip[1]

            split(final_time[l], f, ":")
            final = f[1]*3600 + f[2]*60 + f[3]

            split(starting_time[l], s, ":")
            initial = s[1]*3600 + s[2]*60 + s[3]

            total_time = final - initial

            throughput = int(no_of_bytes[l]/total_time)

            printf "B-->A #packets=%d, #datapackets=%d, #bytes=%s, xput=%d bytes/sec\n",no_of_packets[l],no_of_data_packets[l],no_of_bytes[l],throughput

            flag2[l]=1;
        }
    }




    for(val in seq){
        cto++
        print cto
        split(seq[val],to_check,"-")
        if(to_check[2]==seq_st[1]){
            delete seq[val]
            seq[$3":"$5"-"to_check[1]"-"seq_lt[1]] = to_check[1]"-"seq_lt[1]
        }
        else if((seq_st[1]>=to_check[1]) && (seq_st[1]< to_check[2])) {
            print (to_check[2] - seq_st[1])

            break;
        }

}
