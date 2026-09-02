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

// the backend sends the last seen unix timestamp, a user counts as online inside this window
export const onlineWindow = 3 * 60 * 1000;

export function presenceStatus(lastSeen?: number): "online" | "offline" {
  if (!lastSeen) return "offline";

  const ms = lastSeen < 10000000000 ? lastSeen * 1000 : lastSeen;

  return Date.now() - ms < onlineWindow ? "online" : "offline";
}

export function timeAgo(timestamp: number, locale: string): string {
  // if timestamp has 10 digits convert it to ms format
  const ms = timestamp < 10000000000 ? timestamp * 1000 : timestamp;

  const rtf = new Intl.RelativeTimeFormat(locale, { numeric: "auto", style: "short" });

  const diffInSeconds = (ms - Date.now()) / 1000;

  const units: { unit: Intl.RelativeTimeFormatUnit; amount: number }[] = [
    { unit: "year", amount: 31536000 },
    { unit: "month", amount: 2592000 },
    { unit: "day", amount: 86400 },
    { unit: "hour", amount: 3600 },
    { unit: "minute", amount: 60 },
    { unit: "second", amount: 1 }
  ];

  for (const { unit, amount } of units) {
    if (Math.abs(diffInSeconds) >= amount || unit === "second")
      return rtf.format(Math.round(diffInSeconds / amount), unit);
  }

  return "";
}
