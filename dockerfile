# syntax=docker/dockerfile:1
FROM ruby:2.7.8
RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn vim

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler:2.2.6
COPY bin/ /app/bin/
RUN bin/bundle install

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb -O /tmp/wkhtmltopdf.deb
RUN apt-get -f -y install /tmp/wkhtmltopdf.deb

# Add a script to be executed every time the container starts.
COPY bin/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80

COPY app/ /app/app/
COPY config/ /app/config/
COPY db/ /app/db/
COPY lib/ /app/lib/
COPY public/ /app/public/
COPY Rakefile /app/
COPY config.ru /app/
COPY *.config.js /app/

COPY yarn.lock /app/
COPY package.json /app/
RUN yarn install

COPY result.csv /app/

ENV RAILS_ENV production
RUN bundle exec rails assets:precompile

# Configure the main process to run when running the image
CMD ["bundle", "exec", "bin/rails", "server", "-p", "80", "-b", "0.0.0.0"]
