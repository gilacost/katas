-module(second).

-export([main/1, readlines/1, chunks/3]).

main(Input) ->
    Lines = readlines(Input),
    Bags = maps:from_list(parse(Lines, [])),

    % TODO decompose this and understand
    Fun = fun F(Bag, V, AccIn) ->
        AccIn + (V * maps:fold(F, 1, maps:get(Bag, Bags, none)))
    end,

    BagsNested = maps:fold(Fun, 0, maps:get(shiny_gold, Bags)),

    erlang:display(BagsNested).

parse_bags(Bags) when length(Bags) > 7 ->
    {[<<Tone/binary>>, <<Color/binary>>, _, _], Rest} = lists:split(4, Bags),
    Bag = binary:bin_to_list(<<Tone/binary, "_", Color/binary>>),
    RestLen = length(Rest) div 3,

    Chunks = chunks(lists:seq(0, RestLen), Rest, []),
    {list_to_atom(Bag),
        maps:from_list(
            lists:map(fun(X) -> rest(X) end, Chunks)
        )};
parse_bags([<<Tone/binary>>, <<Color/binary>>, _, _, _, _, _]) ->
    Bag = binary:bin_to_list(<<Tone/binary, "_", Color/binary>>),
    {list_to_atom(Bag), #{}}.

rest([<<NQty/binary>>, <<NTone/binary>>, <<NColor/binary>>, _]) ->
    NextContainedBag = binary:bin_to_list(<<NTone/binary, "_", NColor/binary>>),
    {list_to_atom(NextContainedBag), parse_int(NQty)}.

chunks([], _List, Buffer) ->
    Buffer;
chunks(_, [], Buffer) ->
    Buffer;
chunks([_H | T], List, Buffer) ->
    {F, S} = lists:split(4, List),
    chunks(T, S, Buffer ++ [F]).

parse_int(<<IntBin/binary>>) ->
    {Int, <<>>} = string:to_integer(IntBin),
    Int.

parse([<<>>], Buffer) ->
    lists:reverse(Buffer);
parse([<<H/binary>> | T], Buffer) ->
    String = binary:split(H, [<<" ">>], [global]),
    BagContents = parse_bags(String),
    parse(T, [BagContents | Buffer]).

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]).
