-module(binary_utils_test).
-include_lib("eunit/include/eunit.hrl").
-include_lib("stdlib/include/assert.hrl").
-import(binary_utils, [to_decimal/1, count/1]).

to_decimal_test() -> 
    Bits1 = [1,1],
    Bits2 = [1,0,1,1,0],
    {A, B} = {to_decimal(Bits1), to_decimal(Bits2)},

    ?assertEqual(3, A),
    ?assertEqual(22, B).

count_test() ->
    Counts = count([
        [1,0,1,1,0],
        [0,0,0,1,0],
        [1,0,1,0,0],
        [0,0,1,1,1]
    ]),
    Expected = [
        [{0,1},{1,0},{0,1},{0,1},{1,0}],
        [{1,0},{1,0},{1,0},{0,1},{1,0}],
        [{0,1},{1,0},{0,1},{1,0},{1,0}],
        [{1,0},{1,0},{0,1},{0,1},{0,1}]
    ],

    ?assertEqual(Expected, Counts).
