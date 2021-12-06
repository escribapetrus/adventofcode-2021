-module(aoc2021_day03).
-behaviour(aoc_puzzle).
-export([
    solve01/1, 
    solve02/1, 
    reduce/3, 
    reduce/2, 
    reduce/1,
    gamma/1, 
    epsilon/1, 
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
-import(binary_utils, [to_decimal/1, count/1]).
-type count() :: {integer(), integer()}.
-type raw_input() :: list(string()).
-type bin_list() :: list(integer()).

solve01(Inputs) -> 
    Parsed = parse(Inputs),
    {Gamma, Epsilon} = {gamma(Parsed), epsilon(Parsed)},
    to_decimal(Gamma) * to_decimal(Epsilon).

solve02(Inputs) -> 
    Parsed = parse(Inputs),
    {Oxygen, CO2} = {oxygen(Parsed), co2(Parsed)},
    to_decimal(Oxygen) * to_decimal(CO2).

-spec parse(raw_input()) -> list(bin_list()).
parse(Inputs) -> 
    Format = fun(X) -> 
        Trimmed = trim(X),
        map(fun binary_utils:to_binary/1, Trimmed)
    end,
    map(Format, Inputs).


gamma({Zeros, Ones}) -> 
    if 
        Ones == Zeros -> 1;
        Ones > Zeros -> 1;
        true -> 0 
    end;
gamma(Inputs) -> 
    Counted = count(Inputs),
    Reduced = reduce(Counted),
    map(fun gamma/1, Reduced).

epsilon({Zeros, Ones}) -> 
    if
        Ones == Zeros -> 0;
        Ones > Zeros -> 0;
        true -> 1
    end;
epsilon(Inputs) -> 
    Counted = count(Inputs),
    Reduced = reduce(Counted),
    map(fun epsilon/1, Reduced).

oxygen(Inputs) -> oxygen(Inputs, 1).
oxygen([H|[]], _) -> H;
oxygen(Inputs, I) ->
    Pattern = gamma(Inputs),
    Filtered = filter_by_index(Inputs, nth(I, Pattern), I),
    oxygen(Filtered, I + 1).

co2(Inputs) -> co2(Inputs, 1).
co2([H|[]], _) -> H;
co2(Inputs, I) ->
    Pattern = epsilon(Inputs),
    Filtered = filter_by_index(Inputs, nth(I, Pattern), I),
    co2(Filtered, I + 1).

-spec filter_by_index(bin_list(), integer(), integer()) -> bin_list().
filter_by_index(List, El, Index) -> 
    F = fun(X) -> nth(Index, X) == El end,
    filter(F, List).

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
