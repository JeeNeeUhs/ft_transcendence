import type { NextConfig } from "next";
import createNextIntlPlugin from "next-intl/plugin";

const withNextIntl = createNextIntlPlugin("./lib/i18n/request.ts");

const nextConfig: NextConfig = {
  output: "standalone",
  turbopack: {
    root: __dirname
  },

  // https://nextjs.org/docs/messages/next-image-unconfigured-host
  images: {
    remotePatterns: [new URL("https://cdn.intra.42.fr/**")]
  }
};

export default withNextIntl(nextConfig);
