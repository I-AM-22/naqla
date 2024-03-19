import { TFunction } from "i18next";

export function withT<TReturn>(
  call: (t: TFunction<string, string>) => TReturn,
) {
  return call;
}
