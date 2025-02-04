FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json tsconfig.json tsconfig.build.json yarn.lock ./
RUN yarn install && yarn cache clean
COPY . .
RUN yarn build


FROM node:18-alpine AS runner
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
ENTRYPOINT [ "sh", "-c" ]
CMD [ "yarn start:prod" ]