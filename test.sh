#!/bin/bash
while [[ $# -gt 1 ]]
do
key="$1"
case "$key" in
"1")
    echo "1"
    ;;
"2" | "3")
    echo "2 | 3"
    ;;
*)
    echo "nothing"
    break
    ;;

esac
done