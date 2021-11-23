%%%-------------------------------------------------------------------
%% @doc adventofcode public API
%% @end
%%%-------------------------------------------------------------------

-module(adventofcode_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    adventofcode_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
