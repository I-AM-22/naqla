import { FetchError } from "@/lib/fetch";
import { UseFormSetError } from "react-hook-form";
import { toast } from "sonner";

export type ApiError = {
  errors?: {
    message: string;
    path: string[];
  }[];
  message?: string;
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

    if (showToast && !data) {
      toast.error(String(err));
    }
    if (data && data.errors) {
      if (setFormError) {
        data.errors?.forEach(
          (error) =>
            setFormError?.(`${error.path.join(".")}`, {
              message: error.message,
            }),
        );
      }
    }
    if (showToast && data && data.message) {
      toast.error(data.message, {});
    }
    return undefined;
  };
}
