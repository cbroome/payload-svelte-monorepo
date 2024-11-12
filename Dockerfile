FROM node:22-alpine as base

RUN npm install -g pm2

WORKDIR /home/node/app/docker-cms-bundle
COPY package.json ./

COPY ecosystem.config.js ./

COPY . .
RUN rm -rf node_modules
# important to reinstall keystone dependencies
RUN rm -rf apps/keystone/node_modules
RUN npm install --omit-dev
# copyfiles needed for svelte
RUN npm install copyfiles -g
ENV NODE_ENV=production

RUN npm run build -w keystone
RUN npm run deploy_migrations -w keystone
RUN npm run build -w svelte

EXPOSE 3000 8080

ENTRYPOINT ["pm2", "--no-daemon", "start"]
CMD ["./ecosystem.config.js"]