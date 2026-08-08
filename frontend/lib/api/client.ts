import { convertKeysToCamelCase, convertKeysToSnakeCase } from "@/lib/utils";

export type Result<T> =
  | {
      success: true;
      data: T;
    }
  | {
      success: false;
      status?: number;
      errorCode: string;
    };

// extends RequestInit for body snake_case conversation
export interface ApiOptions extends Omit<RequestInit, "body"> {
  body?: unknown;
}

const base_url = process.env.NEXT_PUBLIC_API_URL;

async function getAccessToken(): Promise<string | null> {
  if (typeof window === "undefined") return null;

  return localStorage.getItem("access_token");
}

export async function apiClient<T>(endpoint: string, options: ApiOptions = {}): Promise<Result<T>> {
  const headers = new Headers(options.headers as HeadersInit);

  if (!headers.has("Content-Type")) headers.set("Content-Type", "application/json");

  const accessToken = await getAccessToken();
  if (accessToken) headers.set("Authorization", `Bearer ${accessToken}`);

  const fetchOptions: RequestInit = {
    ...options,
    headers
  } as RequestInit;

  if (options.body) {
    const snakeCaseBody = convertKeysToSnakeCase(options.body);
    fetchOptions.body = JSON.stringify(snakeCaseBody);
  }

  try {
    const response = await fetch(`${base_url}/api${endpoint}`, fetchOptions);

    if (!response.ok) {
      let errorCode = `HTTP_${response.status}`;

      try {
        const responseErr = await response.json();

        if (responseErr?.code) {
          errorCode = responseErr.code;
        }
      } catch {}

      return {
        success: false,
        status: response.status,
        errorCode
      };
    }

    if (response.status === 204) {
      return {
        success: true,
        data: {} as T
      };
    }

    return {
      success: true,
      data: convertKeysToCamelCase<T>(await response.json())
    };
  } catch {
    return {
      success: false,
      errorCode: "NETWORK_ERROR"
    };
  }
}
