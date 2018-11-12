FROM mhart/alpine-node

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --prod

FROM alpine:3.7
COPY --from=0 /usr/bin/node /usr/bin/
COPY --from=0 /usr/lib/libgcc* /usr/lib/libstdc* /usr/lib/
WORKDIR /app
COPY --from=0 /app .
COPY src /app/src
COPY bin /app/bin
EXPOSE 1099
CMD ["node", "bin/log-server.js", "-p", "1099", "-d", "log"]
