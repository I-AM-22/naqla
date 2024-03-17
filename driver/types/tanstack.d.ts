import { FetchError } from "@/lib/fetch";
import { ApiError } from "@/utils/apiHelpers";

declare module "@tanstack/react-query" {
  interface Register {
    defaultError: FetchError<ApiError>;
  }
}
