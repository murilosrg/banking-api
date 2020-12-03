FROM elixir:alpine

WORKDIR /app

COPY . /app

RUN apk add --update postgresql-client tzdata git inotify-tools npm make gcc libc-dev

ENV MIX_ENV=prod

RUN mix do local.hex --force, local.rebar --force

RUN mix do deps.get, deps.clean --unused, compile

CMD ["mix", "phx.server"]