-module(aoc2021_day03).
-behaviour(aoc_puzzle).
-export([parse/1, solve01/1, solve02/1, reduce/3, reduce/2, reduce/1, gamma/1, epsilon/1, parse_bits/1]).
-import(lists, [map/2, foldl/3, reverse/1, duplicate/2]).
-import(string, [split/2, trim/1, split/2]).

parse(Inputs) ->
    Format = fun(X) -> 
        Trimmed = trim(X),
        Mapped = map(fun parse_int/1, Trimmed),
        map(fun count/1, Mapped)
    end,
    map(Format, Inputs).

parse_bits(List) ->
    Size = length(List),
    Bin = construct_bin(List),
    <<Value:(Size)>> = Bin,
    Value.

construct_bin(List) ->
    construct_bin(List, <<>>).

construct_bin([], Acc) -> Acc;
construct_bin([X | T], Acc) -> 
    construct_bin(T, <<Acc/bitstring, X:1>>).

solve01(Inputs) -> 
    Reduced = reduce(Inputs),
    Gamma = gamma(Reduced),
    Epsilon = epsilon(Reduced),
    parse_bits(Gamma) * parse_bits(Epsilon).

solve02(_Inputs) -> 2.

count(Bin) -> 
    case Bin of
        0 -> {1, 0};
        1 -> {0, 1}
    end.

parse_int(I) ->
    case I of
        48 -> 0;
        49 -> 1
    end.

reduce(List) -> 
    [A|_] = List,
    Zeros = duplicate(length(A), {0,0}),
    reduce(List, Zeros).

reduce([], Acc) -> Acc;
reduce([A|Rest], Acc) ->
    Sum = reduce(A, Acc, []),
    reduce(Rest, Sum).

reduce([], [], Res) -> reverse(Res);
reduce([{A, B}|T], [{C, D}|S], Res) -> 
    reduce(T, S, [{A + C, B + D}| Res]).

gamma({Zeros, Ones}) -> 
    if 
        Zeros >= Ones -> 0;
        true -> 1 
    end;
gamma(Pairs) -> map(fun gamma/1, Pairs).

epsilon({Zeros, Ones}) -> 
    if
        Ones >= Zeros -> 0;
        true -> 1
    end;
epsilon(Pairs) -> map(fun epsilon/1, Pairs).

