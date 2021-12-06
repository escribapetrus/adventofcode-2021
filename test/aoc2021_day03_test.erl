-module(aoc2021_day03_test).

-include_lib("eunit/include/eunit.hrl").
-include_lib("stdlib/include/assert.hrl").

-import(aoc2021_day03, [
    parse/1, 
    parse_count/1, 
    solve01/1, 
    solve02/1, 
    reduce/3, 
    reduce/1, 
    gamma/1, 
    epsilon/1, 
    convert/1, 
    filter_by_index/3,
    filter_inputs/2]).
-import(inputs, [readlines/1]).

solve01_test() -> 
    Inputs = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ],
    Res = solve01(Inputs),

    ?assertEqual(198, Res).

solve02_test() ->
    Inputs = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ],    
    Res = solve02(Inputs),

    ?assertEqual(230, Res).

parse_test() ->
    Inputs = readlines("priv/inputs/2021/input03"),
    [H|_T] = parse(Inputs),
    Expected = [1,0,0,0,0,0,1,0,1,1,0,1],

    ?assertEqual(Expected, H).

parse_count_test() ->
    Inputs = readlines("priv/inputs/2021/input03"),
    [H|_T] = parse_count(parse(Inputs)),
    Expected = [{0,1},{1,0},{1,0},{1,0},{1,0},{1,0},{0,1},{1,0},{0,1},{0,1},{1,0},{0,1}],

    ?assertEqual(Expected, H).

convert_test() -> 
    Bits1 = [1,1],
    Bits2 = [1,0,1,1,0],
    {A, B} = {convert(Bits1), convert(Bits2)},

    ?assertEqual(3, A),
    ?assertEqual(22, B).

gamma_test() ->
    Inputs = parse_count(parse([
        "00100",
        "11110",
        "10110",
        "10111"
    ])),
    Reduced = reduce(Inputs),
    Gamma = gamma(Reduced),
    ?assertEqual([1,0,1,1,0], Gamma).

epsilon_test() ->
    Inputs = parse_count(parse([
        "00100",
        "11110",
        "10110",
        "10111"
    ])),
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
    Inputs = parse_count(parse([
        "00100",
        "11110",
        "10110",
        "10111"
    ])),
    Res = reduce(Inputs),
    ?assertEqual([{1,3},{3,1},{0,4},{1,3},{3,1}], Res).

filter_by_index_test() ->
    Inputs = [
        [0,0,1,0,0],
        [1,1,1,1,0],
        [1,0,1,1,0],
        [1,0,1,1,1]
    ],
    Expected = [
        [1,1,1,1,0],
        [1,0,1,1,0],
        [1,0,1,1,1]
    ],
    Res = filter_by_index(Inputs, 1, 4),

    ?assertEqual(Expected,Res). 