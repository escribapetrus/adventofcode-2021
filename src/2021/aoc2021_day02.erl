-module(aoc2021_day02).
-behaviour(aoc_puzzle).
-export([parse/1, solve01/1, solve02/1]).
-import(lists, [map/2, foldl/3]).
-import(string, [split/2, trim/1]).

-type direction() :: up | down | forward | invalid.
-type input() :: {direction(), integer()}.

-spec parse(list(string())) -> list(input()).
parse(Inputs) ->
    Format = fun(X) -> 
        [A,B] = split(trim(X), " "),
        {parse_direction(A), list_to_integer(B)}
        end,
    map(Format, Inputs).

-spec solve01(list(input())) -> integer().
solve01(Inputs) ->
    F = fun({Direction, Value}, {X, Y}) -> 
            case Direction of
                up -> {X, Y - Value};
                down -> {X, Y + Value};
                forward -> {X + Value,  Y};
                _Otherwise -> 
                    erlang:display({error, "something went wrong here"}),
                    {X, Y}
            end
        end,
    Acc = {0,0},
    {X, Y} = foldl(F, Acc, Inputs),
    X * Y.

-spec solve02(list(input())) -> integer().
solve02(Inputs) ->
    F = fun({Direction, Value}, {X, Y, Aim}) -> 
            case Direction of
                up -> {X, Y, Aim - Value};
                down -> {X, Y, Aim + Value};
                forward -> {X + Value,  Y + (Aim * Value), Aim};
                _Otherwise -> 
                    erlang:display({error, "something went wrong here"}),
                    {X, Y, Aim}
            end
        end,
    Acc = {0,0,0},
    {X, Y, _Aim} = foldl(F, Acc, Inputs),
    X * Y.

-spec parse_direction(string()) -> direction().
parse_direction(X) ->
    case X of
        "up" -> up;
        "down" -> down;
        "forward" -> forward;
        _ -> invalid
    end.