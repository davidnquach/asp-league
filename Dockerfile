FROM ruby:latest
MAINTAINER David Quach <davidnquach@gmail.com>

RUN gem install bundler

WORKDIR /app
COPY . /app

RUN bundle install
