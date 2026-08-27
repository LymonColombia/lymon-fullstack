# Dev image for lymon-backend (NestJS). No source is copied at build time —
# the submodule folder is bind-mounted by docker-compose.dev.yml and the
# entrypoint runs `pnpm install` on every start, so switching branches in
# lymon-backend/ just works: next `docker compose up` (or restart) re-syncs
# deps for whatever branch is checked out.
FROM node:20-alpine

WORKDIR /app

# bcrypt (native module) needs a toolchain to rebuild for the container's arch
RUN apk add --no-cache python3 make g++ \
    && corepack enable \
    && corepack prepare pnpm@10.33.0 --activate

COPY entrypoint.dev.sh /usr/local/bin/entrypoint.dev.sh
RUN chmod +x /usr/local/bin/entrypoint.dev.sh

EXPOSE 3000

ENTRYPOINT ["entrypoint.dev.sh"]
CMD ["pnpm", "run", "start:dev"]
