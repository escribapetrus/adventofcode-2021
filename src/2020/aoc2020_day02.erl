-module(aoc2020_day02).
-export([parse/1, solve01/1, solve02/1, create_policy/1, validate/1, validate_new/1]).
-import(lists, [map/2, filter/2, nth/2]).

-behaviour(aoc_puzzle).
-record(policy, {min :: integer(), max :: integer(), letter :: char()}).

-type password() :: string().
-type policy() :: #policy{}.
-type inputs() :: list({policy(), password()}).
-type raw_data() :: list(string()).
-type solution() :: integer().

-spec parse(raw_data()) -> inputs().
parse(Inputs) -> 
    Format = fun(X) -> 
        String = string:trim(X),
        [Policy, Password] = string:split(String, ": "),
        {create_policy(Policy), Password}
    end,
    map(Format, Inputs).

-spec solve01(inputs()) -> solution().
solve01(Inputs) -> 
    ValidPasswords = filter(fun validate/1, Inputs),
    length(ValidPasswords).

solve02(Inputs) -> 
    ValidPasswords = filter(fun validate_new/1, Inputs),
    length(ValidPasswords).

-spec create_policy(string()) -> policy().
create_policy(String) -> 
    {ok, Expression} = re:compile("([0-9]+)-([0-9]+) ([a-zA-Z])$"),
    {match, [Min, Max, Letter]} = re:run(String,Expression, [{capture, [1,2,3], list}]),
    #policy{min = list_to_integer(Min), max = list_to_integer(Max), letter = hd(Letter)}.

-spec validate({policy(), password()}) -> boolean().
validate({Policy, Password}) -> 
    Filtered = filter(fun(X) -> X == Policy#policy.letter end, Password),
    (length(Filtered) >= Policy#policy.min) and (length(Filtered) =< Policy#policy.max).

-spec validate_new({policy(), password()}) -> boolean().
validate_new({Policy, Password}) -> 
    A = nth(Policy#policy.min, Password),
    B = nth(Policy#policy.max, Password),
    (A == Policy#policy.letter) xor (B == Policy#policy.letter).

