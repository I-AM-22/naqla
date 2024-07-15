import { getUser } from "@/actions/auth";
import { AuthAdminResponse } from "@/service/api.schemas";
import { getCookie } from "@/utils/cookies";

export type FetchOptions = {
  baseURL?: string;
  headers?: Record<string, string>;
  url: string;
  method:
    | "get"
    | "post"
    | "put"
    | "delete"
    | "patch"
    | "GET"
    | "POST"
    | "PUT"
    | "DELETE"
    | "PATCH";
  params?: any;
  data?: any;
  responseType?: string;
  signal?: AbortSignal;
};

export type FetchResponse<T = unknown> = {
  data: T;
  headers: {
    authorization?: string | null;
    "x-total-count"?: string | null;
  };
};

export type FetchError<T = unknown> = {
  data: T;
  status: number;
};

export const getResponseBody = <T>(response: Response): Promise<T> => {
  const contentType = response.headers.get("content-type");

  if (contentType && contentType.includes("application/json")) {
    return response.json();
  }

  if (contentType && contentType.includes("application/pdf")) {
    return response.blob() as Promise<T>;
  }

  return response.text() as Promise<T>;
};
export function getUserClient() {
  const userCookie = getCookie("user");
  const user = userCookie
    ? (JSON.parse(userCookie) as AuthAdminResponse)
    : undefined;
  return user;
}
export const fetchInstance = async <T>(
  config: FetchOptions,
  init?: RequestInit,
): Promise<FetchResponse<T>> => {
  const isFormData = config.headers?.["Content-Type"] === "multipart/form-data";
  const isJson = config.headers?.["Content-Type"] === "application/json";
  const user = typeof window === undefined ? getUserClient() : await getUser();

  const headers = {
    authorization: config.headers?.["authorization"] ?? `Bearer ${user?.token}`,
    ...config.headers,
    ...(isJson ? { "Content-Type": "application/json" } : {}),
  };

  // Remove Content-Type header if it's not needed to avoid issues
  if (!isJson) {
    delete headers["Content-Type"];
  }
  await new Promise((res) => setTimeout(res, 1000));
  const response = await fetch(
    `${process.env.NEXT_PUBLIC_SERVER_URL}${config.url}` +
      (config.params ? `?${new URLSearchParams(config.params)}` : ""),
    {
      method: config.method,
      ...(config.data
        ? { body: !isFormData ? JSON.stringify(config.data) : config.data }
        : {}),
      headers,
      signal: config.signal,
      cache: "no-cache",
      ...init,
      next: { ...init?.next },
    },
  );

  const data = await getResponseBody<T>(response);

  if (!response.ok) {
    throw {
      status: response.status,
      data,
    };
  }
  return {
    headers: {
      authorization: response.headers.get("authorization"),
    },
    data,
  };
};
