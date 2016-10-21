FROM ruby:latest
MAINTAINER David Quach <https://github.com/davidnquach>

RUN gem install bundler

WORKDIR /app
COPY . /app

RUN bundle install
RUN rails db:migrate
RUN rails db:seed
