FROM ruby:2.6-buster

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

WORKDIR /app

# Upgrading to 3.3.22 to avoid compatibility issues with ruby-ffi
RUN gem update --system 3.3.22

# Installing Gemfile.lock bundler
RUN gem install bundler -v 1.17.3

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . /app

EXPOSE 3000

CMD ["sh", "-c", "bundle install && rails server -b 0.0.0.0"]