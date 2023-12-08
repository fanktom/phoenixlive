FROM elixir:1.15

RUN apt-get update && apt-get install -y build-essential libpq-dev postgresql-client

WORKDIR /phoenix

# bundle up
#COPY Gemfile Gemfile.lock ./
#RUN bundle install

# Entrypoint prepares the database.
#ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
#EXPOSE 3000
#CMD ["./bin/dev"]