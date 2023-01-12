FROM ruby:3.1.2-alpine AS builder
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apk add \
build-base \
postgresql-dev 



COPY Gemfile* ./
RUN bundle install
FROM ruby:3.1.2-alpine AS runner
RUN apk add \
    tzdata \
    nodejs \
    postgresql-dev 


WORKDIR /app




WORKDIR /app
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . .
# RUN gem install bundler
# RUN gem install rails
# RUN bundle install
# COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
# CMD bundle exec rails s -p 3000 -b '0.0.0.0'