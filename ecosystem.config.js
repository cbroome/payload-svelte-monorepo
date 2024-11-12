module.exports = {
  apps: [
    {
      name: "svelte",
      script: "./apps/svelte/build/index.js",
    },
    {
      cwd: "./apps/keystone",
      // script: "npm run build && npm start",
      script: "npm run dev",
      instances: 1,
      autorestart: true,
      max_memory_restart: "1G",
      env: {
        NODE_ENV: "production",
      },
    },
  ],
};
