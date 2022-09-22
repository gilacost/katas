-module(first).

-export([main/1, readlines/1]).

main(Input) ->
    Commands = readlines(Input),
    FirstCommand = {1, maps:get(1, Commands)},
    execute(FirstCommand, 0, Commands, []).

execute({Index, {Cmd, Value}}, Acc, Commands, Executed) ->
    {NewAcc, NewIndex} =
        case Cmd of
            acc -> {Acc + Value, Index + 1};
            nop -> {Acc, Index + 1};
            jmp -> {Acc, Index + Value}
        end,
    HasBeenExecuted = lists:member(NewIndex, Executed),
    if
        HasBeenExecuted ->
            io:format("Acc: ~p~nIndex: ~p~n", [NewAcc, NewIndex]),
            erlang:error("Instruction already executed");
        true ->
            NewCommand = maps:get(NewIndex, Commands),
            execute({NewIndex, NewCommand}, NewAcc, Commands, [NewIndex | Executed])
    end.

readlines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    BinSplit = binary:split(Data, [<<"\n">>], [global]),
    parse(BinSplit, [], 0).

parse_instruction(<<Cmd:3/binary, " ", Sign:1/binary, Value/binary>>, Index) ->
    {Index, {command(Cmd), value(Sign, Value)}}.

command(Cmd) when (Cmd == <<"nop">>) or (Cmd == <<"acc">>) or (Cmd == <<"jmp">>) ->
    binary_to_atom(Cmd);
command(Cmd) ->
    erlang:error("Invalid command" ++ Cmd).

value(Sign, Value) ->
    {Int, <<>>} = string:to_integer(Value),
    case Sign of
        <<"-">> -> -Int;
        _ -> Int
    end.

parse([<<>>], Buffer, _Index) ->
    maps:from_list(lists:reverse(Buffer));
parse([<<H/binary>> | T], Buffer, Index) ->
    NewIndex = Index + 1,
    parse(T, [parse_instruction(H, NewIndex) | Buffer], NewIndex).
