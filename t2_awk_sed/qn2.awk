#!/usr/bin/gawk

BEGIN{
    a[1][1]=0
}

{
    packets[$3":"$5]++
    if($NF != 0){
        datapackets[$3":"$5]  = datapackets[$3":"$5] + 1
        seq[$3":"$5"-"$9] = $9
    }

    else{
        datapackets[$3":"$5]  = datapackets[$3":"$5] + 0
    }

    bytes[$3":"$5] = bytes[$3":"$5] + $NF

    if(! last_packets[$3":"$5]){
        first_packet[$3":"$5] =$1
        last_packets[$3":"$5] = $1
        retransmission[$3":"$5] = 0
        seq[$3":"$5]["0:0"]="11:12"

    }

    last_packets[$3":"$5] = $1

    if(seq_stamp[$3":"$5":"$9]==1){
        retransmission[$3":"$5] = retransmission[$3":"$5] + $NF
    }
    else{
        seq_stamp[$3":"$5":"$9] = 1
    }

}


END{
    for (var in packets){
        if(flag[var] != 1){
            split(var,ip,":")
            rev_var = ip[2]":"ip[1]":"

            split(first_packet[var],a,":")
            split(last_packets[var],b,":")
            total_time = 3600*(b[1] - a[1]) + 60 *(b[2]-a[2]) + (b[3]-a[3])

            split(first_packet[rev_var],ra,":")
            split(last_packets[rev_var],rb,":")
            rev_total_time = 3600*(rb[1] - ra[1]) + 60 *(rb[2]-ra[2]) + (rb[3]-ra[3])

            split(ip[1], ip1, ".")
            ip1_with_colon = ip1[1]"."ip1[2]"."ip1[3]"."ip1[4]":"ip1[5]
            split(ip[2], ip2, ".")
            ip2_with_colon = ip2[1]"."ip2[2]"."ip2[3]"."ip2[4]":"ip2[5]

            print "Connection (A="ip1_with_colon" B="ip2_with_colon")"
            printf "A-->B #packets=%d, #datapackets=%d, #bytes=%s, #retrans=%d xput=%d bytes/sec\n",packets[var],datapackets[var],bytes[var],retransmission[var],int(bytes[var]/total_time)
            printf "B-->A #packets=%d, #datapackets=%d, #bytes=%s, #retrans=%d xput=%d bytes/sec\n",packets[rev_var],datapackets[rev_var],bytes[rev_var],retransmission[rev_var],int(bytes[rev_var]/rev_total_time)
            flag[rev_var]=1;
        }
    }
}
