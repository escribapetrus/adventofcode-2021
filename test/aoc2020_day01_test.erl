-module(aoc2020_day01_test).

-include_lib("eunit/include/eunit.hrl").
-include_lib("stdlib/include/assert.hrl").

-import(aoc2020_day01, [solve01/1, solve02/1, parse/1]).

parse_test() -> 
    Inputs = inputs:readlines("priv/inputs/2020/input01"),
    [H|_T] = parse(Inputs),

    ?assertEqual(H, 1046).

solve01_test() -> 
    Inputs = inputs:readlines("priv/inputs/2020/input01"),
    Solution = solve01(parse(Inputs)),
    ?assertEqual(Solution, 888331).

solve02_test() -> 
    Inputs = inputs:readlines("priv/inputs/2020/input01"),
    Solution = solve02(parse(Inputs)),
    ?assertEqual(Solution, 130933530).
