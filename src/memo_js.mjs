export function memo(f, then_fn) {
  const cache = new Map();

  const memoFun = (x) => {
    if (cache.has(x)) {
      return cache.get(x);
    }
    const value = f(memoFun, x);
    cache.set(x, value);
    return value;
  };

  return then_fn(memoFun);
}
