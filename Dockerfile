# ====== backend build layer ==================================================
FROM bitwalker/alpine-elixir:1.10.2 as backend

WORKDIR /build
COPY mix.exs mix.exs
COPY mix.lock mix.lock

ENV MIX_ENV prod
ENV SECRET_KEY_BASE dummy-value-for-build

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

COPY . .
RUN mix phx.digest
RUN mix release

# ====== service layer ========================================================
FROM alpine:3.11.5

RUN apk --no-cache add \
        ncurses-libs \
        openssl

WORKDIR /app
COPY --from=backend /build/_build/prod/rel/pastie .

CMD ["./bin/pastie", "start"]
