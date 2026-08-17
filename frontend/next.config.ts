import type { NextConfig } from "next";
import createNextIntlPlugin from "next-intl/plugin";

const withNextIntl = createNextIntlPlugin("./i18n/request.ts");

const nextConfig: NextConfig = {
  output: "standalone",

  images: {
    remotePatterns: [new URL("https://cdn.intra.42.fr/**")]
  }
};

export default withNextIntl(nextConfig);
