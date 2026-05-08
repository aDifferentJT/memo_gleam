-module(memo_erl).
-export([memo/2]).

memo(F, Then) ->
  TableId = ets:new(memo_table, [private]),
  MemoFun = fun(X) -> memo_call(TableId, F, X) end,
  Result = Then(MemoFun),
  ets:delete(TableId),
  Result.

memo_call(TableId, F, X) ->
  case ets:lookup(TableId, X) of
    [{X, Value}] -> Value;
    [] ->
      MemoFun = fun(Y) -> memo_call(TableId, F, Y) end,
      Value = F(MemoFun, X),
      ets:insert(TableId, {X, Value}),
      Value
  end.
