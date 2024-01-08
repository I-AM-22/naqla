// custom-instance.ts

const baseURL = "https://petstore.swagger.io/v2"; // use your own URL here or environment variable

export const fetchInstance = async <T>({
  url,
  method,
  params,
  data,
  init,
}: {
  url: string;
  method: "GET" | "POST" | "PUT" | "DELETE" | "PATCH";
  params?: any;
  data?: unknown;
  init?: RequestInit;
  responseType?: string;
}): Promise<T> => {
  const response = await fetch(
    `${baseURL}${url}` + new URLSearchParams(params),
    {
      method,
      ...(data ? { body: JSON.stringify(data) } : {}),
      ...init,
    },
  );

  return response.json();
};

export default fetchInstance;
