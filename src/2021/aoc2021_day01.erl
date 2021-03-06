-module(aoc2021_day01).
-export([solve01/1, solve02/1, parse/1, triplets/1]).
-import(lists, [map/2, foldl/3, reverse/1]).
-import(string, [trim/1]).

-spec parse(list(string())) -> list(integer()).
parse(Inputs) -> 
    Format = fun(X) -> list_to_integer(trim(X)) end,
    map(Format, Inputs).

-spec solve01(list(integer())) -> integer().
solve01(Inputs) ->
    Format = fun(X, {A, Count})  -> 
        if 
            X > A -> {X, Count + 1};
            true -> {X, Count}
        end
    end,
    Acc = {0, 0},
    {_El, Res} = foldl(Format, Acc, Inputs),

    Res - 1.

-spec solve02(list(integer())) -> integer().
solve02(Inputs) -> 
    Triplets = triplets(Inputs),
    Sums = map(fun lists:sum/1, Triplets),
    solve01(Sums).

-spec triplets(list()) -> list().
triplets(List) -> reverse(triplets(List, [])).

-spec triplets(list(), list()) -> list().
triplets([_A, _B | []], Acc) -> Acc; 
triplets([A,B,C|T], Acc) -> 
    Rem = [B, C | T],
    Res = [[A, B, C] | Acc],
    triplets(Rem, Res).




