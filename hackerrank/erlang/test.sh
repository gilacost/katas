#!/bin/bash

rebar3 eunit -d hackerl_rank/src
dir=$(pwd)
for file in ./Exercism/erlang/* .*/ ; do
  cd $dir/$file;
  rebar3 eunit;
done

rm -fv **/*.beam
