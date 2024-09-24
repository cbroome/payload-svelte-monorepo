FROM node:22-alpine as base

FROM base as builder

WORKDIR /home/node/app
COPY package.json ./

COPY . .
RUN rm -rf node_modules
RUN rm -rf app/payload/node_modules
# copyfiles needed for svelte
RUN npm install
RUN npm install copyfiles -g
RUN npm run build -w payload
RUN PORT=5173 npm run build -w svelte

EXPOSE 3000 5173


FROM base as payload

ENV NODE_ENV=production
ENV PAYLOAD_CONFIG_PATH=app/payload/dist/payload.config.js

WORKDIR /home/node/app
COPY package*.json  ./
COPY --from=builder /home/node/app/app/payload/dist ./payload/dist
COPY --from=builder /home/node/app/app/payload/build ./payload/build
CMD ["node", "dist/server.js"]


FROM base as svelte

ENV NODE_ENV=production

WORKDIR /home/node/app
COPY package*.json  ./
COPY --from=builder /home/node/app/app/svelte/build ./svelte/build
CMD ["PORT=5173 node", "svelte/build/index.js"]