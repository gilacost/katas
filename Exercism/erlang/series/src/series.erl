-module(series).

-export([slices/2]).

slices(SliceLength, Series) when SliceLength =< 0 ->
    erlang:error("Slice length can't be 0 or negative", {0, Series});
slices(SliceLength, Series) when SliceLength > length(Series) ->
    erlang:error("Slice length can't be higher than series length", {SliceLength, Series});
slices(SliceLength, []) ->
    erlang:error("Not empty list for series", {SliceLength, []});
slices(SliceLength, Series) ->
    [string:slice(Series, 0, SliceLength) | do_slice(Series, SliceLength)].

do_slice(List, SliceLength) when is_list(List) ->
    do_slice(List, SliceLength, []).

do_slice([], _SliceLength, Buffer) when is_list(Buffer) ->
    Buffer;
do_slice([_H | T], SliceLength, Buffer) when is_list(Buffer) ->
    Slice = string:slice(T, 0, SliceLength),
    BufferReturn = clean_slice(Slice, SliceLength, Buffer),

    do_slice(T, SliceLength, BufferReturn).

clean_slice(Slice, SliceLength, BufferReturn) when length(Slice) /= SliceLength -> BufferReturn;
clean_slice(Slice, _SliceLength, BufferReturn) -> BufferReturn ++ [Slice].
