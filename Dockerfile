FROM starefossen/ruby-node:2-8-stretch
# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y nano build-essential libpq-dev postgresql-client && gem install bundler
# Define where our application will live inside the image
RUN mkdir /dcopyright
# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
COPY Gemfile Gemfile.lock dcopyright/
# Set our working directory inside the image
WORKDIR /dcopyright
# Finish establishing our Ruby enviornment
RUN bundle install
# copy over rails files to $RAILS_ROOT
COPY . /dcopyright