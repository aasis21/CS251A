#!/usr/bin/gawk
BEGIN{
    RS="[/][*]|[/][/]|\42|\41'"
    string_has_started = 0
    comment = 0
    string_count = 0
    multi=0
}

{

    if(RT=="//"){
        comment++
        RS="\n"
    }
    else if(RT=="\42"){
        if(string_has_started==1){
            string_count++
            RS="[/][*]|[/][/]|\42"
            string_has_started=0
        }
        else{
            string_has_started=1
            RS="\42"

        }
    }
    else if(RT=="\41"){
        if(string_has_started==1){
            string_count++
            RS="[/][*]|[/][/]|\42"
            string_has_started=0
        }
        else{
            string_has_started=1
            RS="\41"

        }
    }
    else if(RT=="/*"){
        RS="[*][/]"
    }
    else if (RT=="*/"){
        lines=split($0,each_line,"\n")
        comment = comment + lines
        multi++
        RS="[/][*]|[/][/]|\42"
    }
    else{
        RS="[/][*]|[/][/]|\42"

    }
}

END{
    print string_count" "comment
}
