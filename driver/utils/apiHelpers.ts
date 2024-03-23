import { FetchError } from "@/lib/fetch";
import { UseFormSetError } from "react-hook-form";
import { ToastAndroid } from "react-native";

export type ApiError = {
  error: {
    response: {
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
export function parseResponseError({ showToast = true, setFormError }: Feedbacks) {
  return (err: FetchError<ApiError>) => {
    const data = err.data;
    if (showToast && data.error.response.message) {
      ToastAndroid.show(data.error.response.message, ToastAndroid.SHORT);
    }
    if (data.error.response.errors) {
      if (setFormError) {
        data.error.response.errors?.forEach((error) =>
          setFormError?.(`${error.path.join(".")}`, { message: error.message })
        );
      }
    }

    if (data.error) return err;
  };
}