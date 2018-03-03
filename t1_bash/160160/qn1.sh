#!/bin/bash

print_num(){
    num=$1
    len=${#num}
    if [ $len -gt 7 ]
    then
        a_crore=$(print_num ${num:0:len-7})
        b_crore=$(echo ${num:len-7:7} | sed 's/^0*//')
        b_crore=$(print_num $b_crore)
        echo $a_crore crore $b_crore
    elif [ $len -gt 5 ]
    then
        a_lakh=$(print_num ${num:0:len-5})
        b_lakh=$(echo ${num:len-5:5} | sed 's/^0*//')
        b_lakh=$(print_num $b_lakh)
        echo $a_lakh lakh $b_lakh
    elif [ $len -gt 3 ]
    then
        a_thousand=$(print_num ${num:0:len-3})
        b_thousand=$(echo ${num:len-3:3} | sed 's/^0*//')
        b_thousand=$(print_num $b_thousand)
        echo $a_thousand thousand $b_thousand
    elif [ $len -gt 2 ]
    then
        a_hundred=$(print_num ${num:0:len-2})
        b_hundred=$(print_num ${num:len-2:2})
        echo $a_hundred hundred $b_hundred
    else
        case $num in
            0) echo zero ;;
            1) echo one ;;
            2) echo two ;;
            3) echo three ;;
            4) echo four ;;
            5) echo five ;;
            6) echo six ;;
            7) echo seven ;;
            8) echo eight ;;
            9) echo nine ;;
            00) echo '' ;;
            01) echo one ;;
            02) echo two ;;
            03) echo three ;;
            04) echo four ;;
            05) echo five ;;
            06) echo six ;;
            07) echo seven ;;
            08) echo eight ;;
            09) echo nine ;;
            10) echo ten ;;
            11) echo eleven ;;
            12) echo twelve ;;
            13) echo thirteen ;;
            14) echo fourteen ;;
            15) echo fifteen ;;
            16) echo sixteen ;;
            17) echo seventeen ;;
            18) echo eightteen ;;
            19) echo nineteen ;;
            20) echo twenty ;;
            30) echo thirty ;;
            40) echo forty ;;
            50) echo fifty ;;
            60) echo sixty ;;
            70) echo seventy ;;
            80) echo eighty ;;
            90) echo ninety ;;
            *)
                if [ $len -eq 0 ]
                then
                    echo
                else
                    a_ten=$(print_num $(( ${num:0:len-1} * 10 )) )
                    b_ten=$(print_num ${num:len-1:1})
                    echo $a_ten $b_ten
                fi
                ;;
        esac
    fi



}


print_num_top(){
    num=$1
    num=$(echo $num | sed 's/^0*//')
    if [ ${#num} -eq 0 ]
    then
        echo zero
    elif [[ $num =~ ^[0-9]{1,11}$ ]]
    then
        echo $(print_num $num)
    else
        echo invalid input
    fi
}

print_num_top $1
