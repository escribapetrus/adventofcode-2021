-module(aoc2021_day02_test).

-include_lib("eunit/include/eunit.hrl").
-include_lib("stdlib/include/assert.hrl").

-import(aoc2021_day02, [parse/1, solve01/1, solve02/1]).
-import(inputs, [readlines/1]).

parse_test() ->
    Inputs = readlines("priv/inputs/2021/input02"),
    [H|_T] = parse(Inputs),
    ?assertEqual({forward, 7}, H).

solve01_test() -> 
    Inputs = [
        {forward, 5},
        {down, 5},
        {forward, 8},
        {up, 3},
        {down, 8},
        {forward, 2}
    ],
    Res = solve01(Inputs),
    ?assertEqual(150, Res).

solve02_test() -> 
    Inputs = [
        {forward, 5},
        {down, 5},
        {forward, 8},
        {up, 3},
        {down, 8},
        {forward, 2}
    ],
    Res = solve02(Inputs),
    ?assertEqual(900, Res).
