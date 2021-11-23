-module(utils_test).
-include_lib("eunit/include/eunit.hrl").
-include_lib("stdlib/include/assert.hrl").

readlines_test() -> 
    Inputs = inputs:readlines("priv/inputs/input_test"),
    [H|_T] = Inputs,
    ?assertEqual(H, "4567"),
    ?assertEqual(length(Inputs), 1).