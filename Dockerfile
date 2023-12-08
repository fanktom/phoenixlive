FROM elixir:1.15

RUN apt-get update && apt-get install -y build-essential libpq-dev postgresql-client inotify-tools

WORKDIR /phoenix

# copy mix
COPY mix.exs mix.lock ./

# setup
RUN mix deps.get
RUN mix assets.setup
RUN mix deps.compile

# prepare db
RUN mix ecto.migrate

# Start the server by default, this can be overwritten at runtime
EXPOSE 4000
CMD ["mix", "phx.server"]