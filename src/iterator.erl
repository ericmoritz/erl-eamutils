% -*- erlang -*-
-module(iterator).
-export([iterate/2]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

iterate(_, {Accum, done}) ->
    Accum;
iterate(Callback, {Accum, Current}) ->
    iterate(
      Callback,
      Callback(Accum, Current)
     ).

-ifdef(TEST).
iterate_test_() ->
    ?_assertEqual(
       [1,2,3,4,5],
       iterate(
         fun(Accum, 0) ->
                 {Accum, done};
            (Accum, Counter) ->
                 {[Counter|Accum], Counter - 1}
         end,
         {[], 5}
        )
      ).
-endif.
