# syntax=docker/dockerfile:1
FROM ruby:2.7
RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn vim npm

# Add a script to be executed every time the container starts.
COPY bin/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80

COPY yarn.lock /app/
COPY package.json /app/
WORKDIR /app
RUN npm install

COPY app/ /app/app/
COPY config/ /app/config/
COPY db/ /app/db/
COPY lib/ /app/lib/
COPY public/ /app/public/
COPY Rakefile /app/
COPY config.ru /app/

COPY result.csv /app/

ENV RAILS_ENV production

# Configure the main process to run when running the image
CMD ["bundle", "exec", "bin/rails", "server", "-p", "80", "-b", "0.0.0.0"]
