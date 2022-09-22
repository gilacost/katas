#!/bin/bash

# You are given a file with four space separated columns containing the scores of students in three subjects. The first column contains a single character (), the student identifier. The next three columns have three numbers each. The numbers are between and

# , both inclusive. These numbers denote the scores of the students in English, Mathematics, and Science, respectively.

# Your task is to identify those lines that do not contain all three scores for students.

declare -A a

fractals() {
    local depth=$1 length=$2 row=$3 column=$4
    [[ $depth -eq 0 ]] && return
    for ((i=length; i; i--)); do
        a[$((row-i)).$column]=1
    done
    ((row -= length))
    for ((i=length; i; i--)); do
        a[$((row-i)).$((column-i))]=1
        a[$((row-i)).$((column+i))]=1
    done
    fractals $((depth-1)) $((length/2)) $((row-length)) $((column-length))
    fractals $((depth-1)) $((length/2)) $((row-length)) $((column+length))
}
read n
fractals $n 16 63 49
for ((i=0; i<63; i++)); do
    for ((j=0; j<100; j++)); do
        if [[ ${a[$i.$j]} ]]; then
            printf 1
        else
            printf _
        fi
    done
    echo
done
