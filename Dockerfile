FROM elixir:1.5.1
RUN apt-get update -qq && apt-get install -y build-essential && apt-get install -y nodejs
RUN apt-get install npm
RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app
ADD . $app
RUN mkdir /app/priv/static
RUN mix deps.get
RUN npm install
CMD ["mix", "phx.server"]
