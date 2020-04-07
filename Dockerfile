FROM ruby:2.3.8

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY . .
RUN bundle install
RUN ls

EXPOSE 3000

ADD    https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /

