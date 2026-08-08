import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

function toCamelCase(str: string): string {
  return str.replace(/_([a-z])/g, (g) => g[1].toUpperCase());
}

function toSnakeCase(str: string): string {
  return str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);
}

export function convertKeysToCamelCase<T = unknown>(obj: unknown): T {
  if (obj === null || typeof obj !== "object") {
    return obj as T;
  }

  if (Array.isArray(obj)) {
    return obj.map((item) => convertKeysToCamelCase(item)) as unknown as T;
  }

  return Object.keys(obj).reduce((acc: Record<string, unknown>, key: string) => {
    const camelKey = toCamelCase(key);
    const value = (obj as Record<string, unknown>)[key];

    acc[camelKey] = convertKeysToCamelCase(value);
    return acc;
  }, {}) as T;
}

export function convertKeysToSnakeCase(obj: unknown): unknown {
  if (obj === null || typeof obj !== "object") {
    return obj;
  }

  if (Array.isArray(obj)) {
    return obj.map((item) => convertKeysToSnakeCase(item));
  }

  return Object.keys(obj).reduce((acc: Record<string, unknown>, key: string) => {
    const snakeKey = toSnakeCase(key);
    const value = (obj as Record<string, unknown>)[key];

    acc[snakeKey] = convertKeysToSnakeCase(value);
    return acc;
  }, {});
}
