##
# BUILD : docker build --pull=true --no-cache --rm -t julienbreux/unicorn-app:1.0 . && docker tag julienbreux/unicorn-app:1.0 julienbreux/unicorn-app:latest
# SHIP  : docker push julienbreux/unicorn-app:1.0 && docker push julienbreux/unicorn-app:latest
# RUN   : docker run -ti --rm julienbreux/unicorn-app:1.0
##

FROM ruby:2.2-onbuild
MAINTAINER Julien Breux "julien.breux@gmail.com"

# Install Rails App
WORKDIR /usr/src/app
ADD Gemfile /usr/src/Gemfile
ADD Gemfile.lock /usr/src/Gemfile.lock
RUN bundle install --without development test
RUN mkdir tmp
ADD . /usr/src/app

# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run app
CMD bundle exec unicorn -c /usr/src/app/config/unicorn.rb
