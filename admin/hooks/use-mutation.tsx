import { FetchError } from "@/lib/fetch";
import { ApiError, parseResponseError } from "@/utils/apiHelpers";
import { FieldValues, UseFormReturn } from "react-hook-form";

export function useMutation<TData, TResult, TForm extends FieldValues>(
  mutationFn: (data: TData) => Promise<TResult>,
  form?: UseFormReturn<TForm>,
) {
  return async (
    data: TData,
    options?: {
      onSuccess?: (result: TResult) => unknown;
      onError?: (err: FetchError<ApiError>) => unknown;
    },
  ) => {
    return mutationFn(data)
      .then((result) => {
        options?.onSuccess?.(result);
        return result;
      })
      .catch((err) => {
        console.error(err);
        options?.onError?.(err) ??
          parseResponseError({ setFormError: form?.setError })(err);
        return undefined;
      });
  };
}
