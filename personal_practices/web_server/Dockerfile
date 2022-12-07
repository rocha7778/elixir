

FROM elixir as build_image
WORKDIR /app
RUN  mix local.hex --force && mix local.rebar --force
COPY mix.exs mix.lock ./
RUN mix deps.get && mix deps.compile
COPY . .
RUN mix distillery.release

FROM elixir
ENV MIX_ENV=prod
USER root
WORKDIR /app
EXPOSE 8081


CMD /app/rel/web_server/bin/web_server foreground