FROM ruby:2.7.0

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile

RUN apt-get update -qq

RUN bundle config set path 'vendor/bundle'
RUN bundle install -j4

ADD . /app