-module(aoc2020_day02_test).

-include_lib("eunit/include/eunit.hrl").
-include_lib("stdlib/include/assert.hrl").

-import(aoc2020_day02, [solve01/1, solve02/1, parse/1, create_policy/1, validate/1, validate_new/1, filter_passwords/1]).

parse_test() ->
    Inputs = inputs:readlines("priv/inputs/2020/input02"),
    [H|_T] = parse(Inputs),

    ?assertEqual(H, {{policy,3,4, $l}, "vdcv"}).

create_policy_test() ->
    String = "7-12 m",
    Res = create_policy(String),

    ?assertEqual(Res, {policy,7,12, $m}).

validate_test() ->
    One = {create_policy("1-3 a"), "abcde"},
    Two = {create_policy("1-3 b"), "cdefg"},
    Three = {create_policy("2-9 c"), "ccccccccc"},

    ?assert(validate(One)),
    ?assert(validate(Two) == false),
    ?assert(validate(Three)).

validate_new_test() ->
    One = {create_policy("1-3 a"), "abcde"},
    Two = {create_policy("1-3 b"), "cdefg"},
    Three = {create_policy("2-9 c"), "ccccccccc"},

    ?assert(validate_new(One)),
    ?assert(validate_new(Two) == false),
    ?assert(validate_new(Three) ==false).

solve01_test() ->
    Inputs = inputs:readlines("priv/inputs/2020/input02"),
    Solution = solve01(parse(Inputs)),

    ?assertEqual(Solution, 447).

solve02_test() ->
    Inputs = inputs:readlines("priv/inputs/2020/input02"),
    Solution = solve02(parse(Inputs)),

    ?assertEqual(Solution, 249).
