BEGIN {
  KEY["a"]="a";
  KEY["b"]="b";
  KEY["c"]="c";
  MULTI["a"]["test_a"]="date a";
  MULTI["b"]["test_b"]="dbte b";
  MULTI["c"]["test_c"]="dcte c";
}
END {
  for(k in KEY) {
    kk="test_" k ;
    print MULTI[k][kk]
  }
  for(q in MULTI) {
    print q
  }
  for(p in MULTI) {
    for( pp in MULTI[p] ) {
      print MULTI[p][pp]
    }
  }
}




split($9,seq_st,":")
if(seq_st[2]){
    split(seq_st[2],seq_lt,",")
    #print seq_st[1] "-" seq_lt[1]
    done=0
    for(val in seq[$3":"$5]){
        #print "value" length(seq[$3":"$5]) "------------" seq[$3":"$5][val]
        #print val

        temp=val
        split(temp,to_check,":")

        if((seq_st[1]>=to_check[1]) && (seq_lt[1]<=to_check[2])) {
            retransmission[$3":"$5] = retransmission[$3":"$5] + seq_lt[1] - seq_st[1]
            done=1
            print "hole"

        }
        if(to_check[2]==seq_st[1]){
            delete seq[val]
            seq[$3":"$5][to_check[1]":"seq_lt[1]] = 1
            done=1
            print "lol"
        }
    }
    if(done==0){
        seq[$3":"$5][seq_st[1]":"seq_lt[1]] = 1
        print "dol"
    }
}
