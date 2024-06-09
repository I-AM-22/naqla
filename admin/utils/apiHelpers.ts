import { FetchError } from "@/lib/fetch";
import { UseFormSetError } from "react-hook-form";
import { toast } from "sonner";

export type ApiError = {
  error: {
    response?: {
      errors?: {
        message: string;
        path: string[];
      }[];
      message?: string;
    };
    status: number;
    message: string;
    name: string;
  };
  stack: string;
  message: string;
};

type Feedbacks = {
  setFormError?: UseFormSetError<any>;
  showToast?: boolean;
};
export function parseResponseError({
  showToast = true,
  setFormError,
}: Feedbacks) {
  return (err: FetchError<ApiError>) => {
    const data = err.data;

    if (showToast && (!data || data?.error.response?.message)) {
      toast.error(data?.error.response?.message ?? String(err));
    }
    if (data && data.error?.response?.errors) {
      if (setFormError) {
        data.error.response.errors?.forEach(
          (error) =>
            setFormError?.(`${error.path.join(".")}`, {
              message: error.message,
            }),
        );
      }
    }
    if (showToast && data && !data.error.response) {
      toast.error(data.message, {});
    }
    return undefined;
  };
}
