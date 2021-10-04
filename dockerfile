# syntax=docker/dockerfile:1
FROM ruby:2.7.2
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler:2.2.6
COPY bin/ /app/bin/
RUN bin/bundle install

RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb -O /tmp/wkhtmltopdf.deb
RUN apt-get -f -y install /tmp/wkhtmltopdf.deb

# Add a script to be executed every time the container starts.
COPY bin/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80

COPY yarn.lock /app/
COPY package.json /app/
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
