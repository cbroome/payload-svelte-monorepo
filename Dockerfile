FROM node:18.8-alpine as base

FROM base as builder

WORKDIR /home/node/app
COPY package*.json ./

COPY . .
RUN npm install
RUN npm run build -w payload

FROM base as runtime

ENV NODE_ENV=production
ENV PAYLOAD_CONFIG_PATH=app/payload/dist/payload.config.js

WORKDIR /home/node/app
COPY package*.json  ./
#COPY package-lock ./

#RUN npm install --omit=dev -w payload
COPY --from=builder /home/node/app/app/payload/dist ./dist
COPY --from=builder /home/node/app/app/payload/build ./build

EXPOSE 3000

CMD ["node", "dist/server.js"]
