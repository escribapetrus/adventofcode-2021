-module(binary_utils).
-export([to_decimal/1, to_binary/1, count/1]).
-import(lists, [map/2]).
-type bin_list() :: list(integer()).
-type count() :: {integer(), integer()}.

-spec to_binary(integer()) -> integer().
to_binary(Char) ->
    case Char of
        48 -> 0;
        49 -> 1
    end.

-spec to_decimal(bin_list()) -> integer().
to_decimal(List) ->
    Size = length(List),
    Bin = construct_bin(List),
    <<Value:(Size)>> = Bin,
    Value.

-spec construct_bin(bin_list()) -> bitstring().
construct_bin(List) -> 
    construct_bin(List, <<>>).
construct_bin([], Acc) -> 
    Acc;
construct_bin([X | T], Acc) -> 
    construct_bin(T, <<Acc/bitstring, X:1>>).

-spec count(list(bin_list())) -> list(count()).
count(Inputs) when is_list(Inputs) ->
    Format = fun(X) -> 
        map(fun count/1, X)
    end,
    map(Format, Inputs);
count(Bin) -> 
    case Bin of
        0 -> {1, 0};
        1 -> {0, 1}
    end.