import { userStore } from "@/stores/user-store";
import ax, { AxiosRequestConfig } from "axios";

export type FetchOptions = {
  baseURL?: string;
  headers?: AxiosRequestConfig<any>["headers"];
  url: string;
  method: "get" | "post" | "put" | "delete" | "patch" | "GET" | "POST" | "PUT" | "DELETE" | "PATCH";
  params?: any;
  data?: any;
  responseType?: string;
  signal?: AbortSignal;
  options?: AxiosRequestConfig;
};

export type FetchResponse<T = unknown> = {
  data: T;
};

export type FetchError<T = unknown> = {
  data: T;
  status: number;
};

let token: string | undefined;
const axios = ax.create({
  baseURL: `${process.env.EXPO_PUBLIC_SERVER_URL}`,
});
axios.interceptors.request.use((config) => {
  token = token ?? userStore.getState().user?.token;
  config.headers["accept"] = "*/*";
  config.headers["Authorization"] = `Bearer ${token}`;
  return config;
});

export const fetchInstance = async <T>(config: FetchOptions): Promise<FetchResponse<T>> => {
  await new Promise((res) => setTimeout(res, 1));
  const response = await axios(
    `${process.env.EXPO_PUBLIC_SERVER_URL}${config.url}` +
      (config.params ? `?${new URLSearchParams(config.params)}` : ""),
    {
      method: config.method,
      ...(config.data ? { data: config.data } : {}),
      headers: config.headers,
      ...config.options,
    }
  );

  return response;
};
userStore.subscribe(({ user }) => {
  token = user?.token;
});
