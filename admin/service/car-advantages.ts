export const carAdvantagesCache = {
  root: "car-advantages/",
  all() {
    return [this.root, this.root.concat("all")];
  },
  details(id: string) {
    return [this.root, this.root.concat(id)];
  },
};

/**WIP */
function withOptions<
  TParams extends [],
  TReturn,
  TFunction extends (...args: TParams) => TReturn,
>(fn: TFunction, outerParams: Parameters<TFunction>) {
  return (...params: Parameters<TFunction>) => {
    for (let i = 0; i < Math.max(params.length, outerParams.length); i++) {
      params[i] = params[i] ?? outerParams[i];
    }
    return fn(...params);
  };
}
