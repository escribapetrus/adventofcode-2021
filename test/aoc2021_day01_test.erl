-module(aoc2021_day01_test).

-include_lib("eunit/include/eunit.hrl").
-include_lib("stdlib/include/assert.hrl").

-import(aoc2021_day01, [solve01/1, solve02/1, parse/1, triplets/1]).
-import(inputs, [readlines/1]).

parse_test() -> 
    Inputs = readlines("priv/inputs/2021/input01"),
    [H|_T] = parse(Inputs),

    ?assertEqual(H ,141).

solve01_test() -> 
    Inputs = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263],
    Res = solve01(Inputs),

    ?assertEqual(7, Res).

solve02_test() ->
    Inputs = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263],
    Res = solve02(Inputs),

    ?assertEqual(5, Res).

triplets_test() -> 
    Inputs = [199, 200, 208, 210, 200, 207, 240, 269, 260],
    Expected = [
        [199, 200, 208],
        [200, 208, 210],
        [208, 210, 200],
        [210, 200, 207],
        [200, 207, 240],
        [207, 240, 269],
        [240, 269, 260]
    ],
    Res = triplets(Inputs),

    ?assertEqual(Expected, Res).