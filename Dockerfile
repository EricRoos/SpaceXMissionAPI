FROM elixir:1.5.1
RUN apt-get update -qq && apt-get install -y build-essential && apt-get install -y nodejs
RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app
ADD . $app
RUN mkdir /app/priv/static
RUN mix deps.get
CMD ["mix", "phx.server"]
