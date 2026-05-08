# memo

A memoization library for Gleam that enables automatic caching of function results across recursive calls, supporting both erlang and javascript targets

## Installation

```sh
gleam add memo@1
```

## Usage

The `memo` function takes a function that receives itself (memoized) as the first argument and the input as the second:

```gleam
import memo.{memo}

fn fibonacci(fib: fn(Int) -> Int, n: Int) -> Int {
  case n {
    0 -> 1
    1 -> 1
    n -> fib(n - 1) + fib(n - 2)
  }
}

pub fn main() {
  use fib_memo <- memo(fibonacci)
  fib_memo(50)  // Efficiently computed with memoization
}
```

## How it works

The key insight is that your function receives the memoized version of itself as the first parameter. When making recursive calls, you call this parameter instead of the function directly. This ensures every subproblem's result is cached after first computation.

For the fibonacci example:
- `fib(50)` calls `fib(49)` and `fib(48)`
- `fib(49)` calls `fib(48)` and `fib(47)`
- The second `fib(48)` is served from cache instead of recomputed

This transforms the exponential time complexity of naive fibonacci into linear time.

## Supported targets

- Erlang
- JavaScript

## Development

```sh
gleam test -t erlang      # Run the tests on erlang
gleam test -t javascript  # Run the tests on javascript
```
