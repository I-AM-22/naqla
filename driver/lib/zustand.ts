import { StoreApi, useStore } from "zustand";

export const createUseStore = ((store) => (selector) => useStore(store, selector as never)) as <
  S extends StoreApi<unknown>,
>(
  store: S
) => {
  (): ExtractState<S>;
  <T>(selector: (state: ExtractState<S>) => T): T;
};

type ExtractState<S> = S extends { getState: () => infer X } ? X : never;
