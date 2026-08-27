# Dev image for lymon-frontend (Angular). No source is copied at build time —
# the submodule folder is bind-mounted by docker-compose.dev.yml and the
# entrypoint runs `pnpm install` on every start, so switching branches in
# lymon-frontend/ just works: next `docker compose up` (or restart) re-syncs
# deps for whatever branch is checked out.
FROM node:20-alpine

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@10.33.0 --activate

COPY entrypoint.dev.sh /usr/local/bin/entrypoint.dev.sh
RUN chmod +x /usr/local/bin/entrypoint.dev.sh

EXPOSE 4200

ENTRYPOINT ["entrypoint.dev.sh"]
CMD ["pnpm", "exec", "ng", "serve", "--host", "0.0.0.0", "--port", "4200"]
