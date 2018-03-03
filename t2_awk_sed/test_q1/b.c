
0 && multiple_line==0 && string==0{
    if($1 ~ /\/\//){
        # starting comment of //.
        comment=comment+1
        print $0
    }
    else if($0 ~ /".*"/ || $0 ~ /'.*'/){
    print "\n"
    print "fdggfd string]]]]]]]]]]]]]]]]" $0
    print NF
    for(i=1;i<=NF;i++){
    print $i
    }
    print "\n"
    }
}

0  && multiple_line==0{
    if($0 ~ /".*".*/)
}

0   {
    print "\n"
    myst=$0
    print myst
    print length(myst)"," index(myst,"/")

    split("cul-de-sac", a, "-")
    for(i in a){
        print a[i]
    }

    c=$0
    ct = gsub(/".*"/,"--p--",c)
    print ct "," c "," $0
    for(i in ct)
    }
    print NF
    print match(myst,/".*"/), RSTART, RLENGTH

}

0{
    split($0, chars, "")
    for (i=1; i <= length($0); i++) {
        printf("%s\n", chars[i])
    }

}
