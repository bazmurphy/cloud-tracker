// neccessary for vitest and typescript:
// these two are for typing and global types
/// <reference types="vitest" />
/// <reference types="vite/client" />

import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
  },
  // "test" can now be used in defineConfig for vitest:
  test: {
    environment: "jsdom",
    globals: true,
    // this path has to be correct
    setupFiles: ["vitest-setup.ts"],
  },
});
