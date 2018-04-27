#!bin/bash
param=$1
thread=$2
for ctr in {1..100}
do
    log=$(./app $param $thread)
    arr=($log)
    echo $ctr $param $thread ${arr[3]}
done
