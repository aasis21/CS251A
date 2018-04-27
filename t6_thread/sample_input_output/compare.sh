if [ "$#" -lt 2 ]; then
    echo "USAGE: $0 original_output_file student_ka_output_file [--limited]"
    exit 1
fi

precision=0.1

join  $1 $2 > "./tmp"

if [ "$3" == "--limited" ]; then
    head -n 100 "./tmp" > "./tmp2"
    mv "./tmp2" "./tmp"
elif [[ "$1" == *"t1"* ]]; then
    echo "checking 10,000 accounts"
else
    echo "did you forget \"--limited\" option?"
fi

awk 'BEGIN{total = 0; match1 = 0; partial = 0;}

     {
         total++;
         if ($2 == $3) match1++;
         if ($2 - $3 <= '$precision' && $3 - $2 <= '$precision') partial++;
     }

     END{print 100*match1/NR "% perfect match";
         print 100*partial/NR "% with less precision" }' "./tmp"

rm ./tmp
