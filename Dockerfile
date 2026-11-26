# syntax=docker/dockerfile:1
# Zero runtime dependencies, so there is nothing to install — just copy the
# source. curl is here because Coolify's HTTP health check runs it inside the
# container, and node:alpine does not ship it.
FROM node:22-alpine

RUN apk add --no-cache curl

WORKDIR /app

COPY package.json ./
COPY server.js ./
COPY core ./core
COPY public ./public
COPY bin ./bin
COPY config ./config

ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=4321

# Watches, alert state and the event log. Mount a volume here in production.
VOLUME ["/app/data"]

EXPOSE 4321

CMD ["node", "server.js"]
