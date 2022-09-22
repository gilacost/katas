#!/bin/bash

read x
read y

echo "$x + $y" | bc
echo "$x - $y" | bc
echo "$x * $y" | bc
echo "$x / $y" | bc
