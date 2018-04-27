if [ "$#" -ne 1 ]; then
    echo "USAGE: $0 acc_no"
    exit 1
fi

if [ "$1" -lt 1001 -o "$1" -gt 11000 ]; then
    echo "Invalid acc_no"
    exit 1
fi

printf "Starting balance : "
awk '{if ($1 == '$1') print $2}' acc_in.txt
echo""

awk '{if ($4 == '$1' || $5 == '$1') print $0}' txn.txt

echo ""
printf "Closing balance : "
awk '{if ($1 == '$1') print $2}' acc_out.txt
