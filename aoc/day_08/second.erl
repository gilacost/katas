-module(second).

-export([main/1, readlines/1]).

main(Input) ->
    {Commands, NopJmpCmds, CmdLen} = readlines(Input),
    FirstCommand = {1, maps:get(1, Commands)},
    execute(FirstCommand, 0, Commands, [], Commands, NopJmpCmds, CmdLen).

execute({Index, {_, _}}, Acc, _, _, _, _, CmdLen) when Index == CmdLen ->
    Acc;
execute({Index, {Cmd, Value}}, Acc, Cmds, Executed, InitialCmds, NopJmpCmds, CmdLen) ->
    {NewAcc, NewIndex} =
        case Cmd of
            acc -> {Acc + Value, Index + 1};
            nop -> {Acc, Index + 1};
            jmp -> {Acc, Index + Value}
        end,
    HasBeenExecuted = lists:member(NewIndex, Executed),
    IsOutOfBounds = (NewIndex < 1) or (NewIndex > CmdLen),
    if
        (HasBeenExecuted or IsOutOfBounds) ->
            [{IndexToRep, {ToRepCmd, ToRepVal}} | NopJmpCmdsTail] = NopJmpCmds,
            NewCmds = maps:update(IndexToRep, {switch(ToRepCmd), ToRepVal}, InitialCmds),
            FirstCmd = {1, maps:get(1, NewCmds)},
            execute(FirstCmd, 0, NewCmds, [], InitialCmds, NopJmpCmdsTail, CmdLen);
        %
        true ->
            NewCommand = maps:get(NewIndex, Cmds),
            execute(
                {NewIndex, NewCommand},
                NewAcc,
                Cmds,
                [NewIndex | Executed],
                InitialCmds,
                NopJmpCmds,
                CmdLen
            )
    end.

switch(nop) ->
    jmp;
switch(jmp) ->
    nop.

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
    NewBuffer = lists:reverse(Buffer),
    NopJmpCmds = lists:filter(fun({_, {Cmd, _}}) -> Cmd /= acc end, NewBuffer),
    {
        maps:from_list(NewBuffer),
        NopJmpCmds,
        length(NewBuffer)
    };
parse([<<H/binary>> | T], Buffer, Index) ->
    NewIndex = Index + 1,
    parse(T, [parse_instruction(H, NewIndex) | Buffer], NewIndex).
