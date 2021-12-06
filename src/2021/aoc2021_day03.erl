-module(aoc2021_day03).
-behaviour(aoc_puzzle).
-export([
    parse_count/1, 
    solve01/1, 
    solve02/1, 
    reduce/3, 
    reduce/2, 
    reduce/1,
    gamma/1, 
    epsilon/1, 
    convert/1, 
    filter_by_index/3,
    parse/1]).
-import(lists, [
    map/2, 
    foldl/3, 
    reverse/1, 
    duplicate/2, 
    filter/2, 
    nth/2]).
-import(string, [split/2, trim/1, split/2]).

-type raw_input() :: list(string()).
-type count() :: {integer(), integer()}.
-type bin_list() :: list(integer()).

solve01(Inputs) -> 
    Parsed = parse(Inputs),
    Counted = parse_count(Parsed),
    Reduced = reduce(Counted),
    {Gamma, Epsilon} = {gamma(Reduced), epsilon(Reduced)},
    convert(Gamma) * convert(Epsilon).

solve02(Inputs) -> 
    Parsed = parse(Inputs),
    {Oxygen, CO2} = {oxygen(Parsed), co2(Parsed)},
    erlang:display({Oxygen, CO2}),
    convert(Oxygen) * convert(CO2).

-spec parse(raw_input()) -> list(bin_list()).
parse(Inputs) -> 
    Format = fun(X) -> 
        Trimmed = trim(X),
        map(fun parse_int/1, Trimmed)
    end,
    map(Format, Inputs).

-spec parse_count(raw_input()) -> list(count()).
parse_count(Inputs) ->
    Format = fun(X) -> 
        map(fun count/1, X)
    end,
    map(Format, Inputs).

-spec convert(bin_list()) -> integer().
convert(List) ->
    Size = length(List),
    Bin = construct_bin(List),
    <<Value:(Size)>> = Bin,
    Value.

-spec construct_bin(bin_list()) -> bitstring().
construct_bin(List) ->
    construct_bin(List, <<>>).
construct_bin([], Acc) -> Acc;
construct_bin([X | T], Acc) -> 
    construct_bin(T, <<Acc/bitstring, X:1>>).

-spec count(integer()) -> count().
count(Bin) -> 
    case Bin of
        0 -> {1, 0};
        1 -> {0, 1}
    end.

-spec parse_int(integer()) -> integer().
parse_int(I) ->
    case I of
        48 -> 0;
        49 -> 1
    end.

gamma({Zeros, Ones}) -> 
    if 
        Ones == Zeros -> 1;
        Ones > Zeros -> 1;
        true -> 0 
    end;
gamma(Pairs) -> map(fun gamma/1, Pairs).

epsilon({Zeros, Ones}) -> 
    if
        Ones == Zeros -> 0;
        Ones > Zeros -> 0;
        true -> 1
    end;
epsilon(Pairs) -> map(fun epsilon/1, Pairs).

-spec reduce(list(count())) -> count().
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

-spec filter_by_index(bin_list(), integer(), integer()) -> bin_list().
filter_by_index(List, El, Index) -> 
    F = fun(X) -> nth(Index, X) == El end,
    filter(F, List).

oxygen(Inputs) -> oxygen(Inputs, 1).
oxygen([H|[]], _) -> H;
oxygen(Inputs, I) ->
    Counted = parse_count(Inputs),
    Reduced = reduce(Counted),
    Pattern = gamma(Reduced),
    Filtered = filter_by_index(Inputs, nth(I, Pattern), I),
    oxygen(Filtered, I + 1).

co2(Inputs) -> co2(Inputs, 1).
co2([H|[]], _) -> H;
co2(Inputs, I) ->
    Counted = parse_count(Inputs),
    Reduced = reduce(Counted),
    Pattern = epsilon(Reduced),
    Filtered = filter_by_index(Inputs, nth(I, Pattern), I),
    co2(Filtered, I + 1).



