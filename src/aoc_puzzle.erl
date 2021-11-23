-module(aoc_puzzle).

-callback solve01(term()) -> term(). 
-callback solve02(term()) -> term().
-callback parse(term()) -> term().