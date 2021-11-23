-module(aoc2020_day01).
-export([solve01/1, solve02/1, parse/1]).
-import(lists, [map/2]).
-import(inputs, [readlines/1]).

-type inputs() :: list(integer()).
-type raw_data() :: list(string()).
-type result() :: integer().

-spec solve01(inputs()) -> result().
solve01(Inputs) -> 
    hd(combinations_of_two(Inputs)).

-spec solve02(inputs()) -> result().
solve02(Inputs) -> 
    hd(combinations_of_three(Inputs)).

-spec parse(raw_data()) -> inputs().
parse(Inputs) -> 
    Format = fun(X) -> list_to_integer(string:trim(X)) end,
    map(Format, Inputs).

-spec combinations_of_two(inputs()) -> integer().
combinations_of_two(Inputs) -> 
    [X * Y || X <- Inputs, Y <- Inputs, X + Y == 2020].

-spec combinations_of_three(inputs()) -> integer().
combinations_of_three(Inputs) -> 
    [X * Y * Z || X <- Inputs, Y <- Inputs, Z <- Inputs, X + Y + Z == 2020].