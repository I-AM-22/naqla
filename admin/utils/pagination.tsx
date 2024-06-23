import { DeepRequired } from "react-hook-form";

export type PaginationSearch = {
  page?: number | undefined;
  limit?: number | undefined;
};

export function paginate({
  page,
}: {
  page?: number;
}): DeepRequired<PaginationSearch> {
  return { page: page ?? 1, limit: 10 };
}
