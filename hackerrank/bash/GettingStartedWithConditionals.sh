#!/bin/bash

read o

case $o in

  [yY]*)
    echo "YES"
    ;;

  [nN]*)
    echo "NO"
    ;;

  *)
    echo "Invalid character"
    exit 1
    ;;
esac
