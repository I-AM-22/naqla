import { FetchError } from "@/lib/fetch";
import { ApiError, parseResponseError } from "@/utils/apiHelpers";
import { useState } from "react";
import { FieldValues, UseFormReturn } from "react-hook-form";

export function useMutation<TData, TResult, TForm extends FieldValues>(
  mutationFn: (data: TData) => Promise<TResult>,
  form?: UseFormReturn<TForm>,
) {
  const [isPending, setIsPending] = useState(false);
  return {
    isPending,
    mutate: async (
      data: TData,
      options?: {
        onSuccess?: (result: TResult) => unknown;
        onError?: (err: FetchError<ApiError>) => unknown;
      },
    ) => {
      setIsPending(true);
      return mutationFn(data)
        .then((result) => {
          options?.onSuccess?.(result);
          setIsPending(false);
          return result;
        })
        .catch((err) => {
          setIsPending(false);
          console.error(err);
          options?.onError?.(err) ??
            parseResponseError({ setFormError: form?.setError })(err);
          return undefined;
        });
    },
  };
}
