FROM ruby:2.6
ENV APP_ROOT /var/www/app
WORKDIR $APP_ROOT

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
    apt-get install -y  --allow-unauthenticated \
    nodejs \
    yarn \
    imagemagick \
    graphviz \
    default-mysql-client \
    default-libmysqlclient-dev

COPY . $APP_ROOT
RUN bundle install


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
