@external(erlang, "memo_erl", "memo")
@external(javascript, "./memo_js.mjs", "memo")
pub fn memo(f: fn(fn(a) -> b, a) -> b, then: fn(fn(a) -> b) -> c) -> c
