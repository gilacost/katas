-module(grains).

-export([square/1, total/0]).

square(Square) when Square > 64 ->
  {error, "square must be between 1 and 64"};
square(Square) when Square =< 0 ->
  {error, "square must be between 1 and 64"};
square(1) ->1;
square(Square) ->
  Board = lists:seq(1 , Square-1),
  do_square(Board, 1).

do_square([], Buffer) -> Buffer;
do_square([ _H | T ] , Buffer) ->
  NewBuffer = Buffer * 2,
  do_square(T, NewBuffer).

total() -> (square(64) * 2) -1.
