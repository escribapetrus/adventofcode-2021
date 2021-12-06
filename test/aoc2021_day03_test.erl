-module(aoc2021_day03_test).

-include_lib("eunit/include/eunit.hrl").
-include_lib("stdlib/include/assert.hrl").

-import(aoc2021_day03, [parse/1, solve01/1, solve02/1, reduce/3, reduce/1, gamma/1, epsilon/1, parse_bits/1]).
-import(inputs, [readlines/1]).

solution_01_test() -> 
    Inputs = parse(readlines("priv/inputs/2021/input03")),
    Res = solve01(Inputs),

    ?assertEqual(0, Res).

parse_test() ->
    Inputs = readlines("priv/inputs/2021/input03"),
    [H|_T] = parse(Inputs),
    Expected = [
        {0,1},
        {1,0},
        {1,0},
        {1,0},
        {1,0},
        {1,0},
        {0,1},
        {1,0},
        {0,1},
        {0,1},
        {1,0},
        {0,1}
    ],

    ?assertEqual(Expected, H).

parse_bits_test() -> 
    Bits1 = [1,1],
    Bits2 = [1,0,1,1,0],
    {A, B} = {parse_bits(Bits1), parse_bits(Bits2)},

    ?assertEqual(3, A),
    ?assertEqual(22, B).

gamma_test() ->
        Inputs = parse([
        "00100",
        "11110",
        "10110",
        "10111"
    ]),
    Reduced = reduce(Inputs),
    Gamma = gamma(Reduced),
    ?assertEqual([1,0,1,1,0], Gamma).

epsilon_test() ->
        Inputs = parse([
        "00100",
        "11110",
        "10110",
        "10111"
    ]),
    Reduced = reduce(Inputs),
    Epsilon = epsilon(Reduced),
    
    ?assertEqual([0,1,0,0,1], Epsilon).

reduce_3_test() ->
    ListOne = [
        {0,1},
        {1,0},
        {0,0}
    ],
    ListTwo = [
        {0,1},
        {1,0},
        {1,0}
    ],
    Expected = [
        {0,2},
        {2,0},
        {1,0}
    ],
    Res = reduce(ListOne, ListTwo, []),

    ?assertEqual(Expected,Res).

reduce_1_test() -> 
    Inputs = parse([
        "00100",
        "11110",
        "10110",
        "10111"
    ]),
    Res = reduce(Inputs),
    ?assertEqual([{1,3},{3,1},{0,4},{1,3},{3,1}], Res).