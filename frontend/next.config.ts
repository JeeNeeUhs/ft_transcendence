import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone",

  // https://nextjs.org/docs/messages/next-image-unconfigured-host
  images: {
    remotePatterns: [new URL("https://cdn.intra.42.fr/**")]
  }
};

export default nextConfig;
