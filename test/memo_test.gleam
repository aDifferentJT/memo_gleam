import gleeunit
import memo.{memo}

pub fn main() -> Nil {
  gleeunit.main()
}

fn fib_inefficient(fib: fn(Int) -> Int, n: Int) -> Int {
  case n {
    0 -> 1
    1 -> 1
    n -> fib(n - 1) + fib(n - 2)
  }
}

fn fib_efficient(n: Int) -> Int {
  fib_efficient_impl(n).0
}

fn fib_efficient_impl(n: Int) -> #(Int, Int) {
  case n {
    0 -> #(1, 0)
    n -> {
      let last = fib_efficient_impl(n - 1)
      #(last.0 + last.1, last.0)
    }
  }
}

pub fn fib_test() {
  let n = 50
  use fib_memo <- memo(fib_inefficient)
  assert fib_memo(n) == fib_efficient(n)
}
