-module(solution_20).

-export([main/0]).

-import(os, [getenv/1]).

sock_merchant(_N, Ar) ->
    SockTypes = remove_dups(Ar),
    TypesGrouped = count_occurrences(SockTypes, Ar),
    lists:foldl(
        fun({_Type, Count}, PairsCount) ->
            PairsCount + floor(Count / 2)
        end,
        0,
        TypesGrouped
    ).

count_occurrences(UniqTypeList, SearchList) ->
    lists:foldl(
        fun(Type, TypesGrouped) ->
            TypesGrouped ++
                [
                    {Type,
                        length(
                            lists:filter(
                                fun(X) ->
                                    X == Type
                                end,
                                SearchList
                            )
                        )}
                ]
        end,
        [],
        UniqTypeList
    ).

remove_dups([]) -> [];
remove_dups([H | T]) -> [H | [X || X <- remove_dups(T), X /= H]].

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {N, _} = string:to_integer(string:chomp(io:get_line(""))),

    ArTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    Ar = lists:map(
        fun(X) ->
            {I, _} = string:to_integer(X),
            I
        end,
        ArTemp
    ),

    Result = sock_merchant(N, Ar),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
