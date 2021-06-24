FROM ruby:2.6
ENV APP_ROOT /var/www/app
WORKDIR $APP_ROOT

RUN mkdir -p /root/tmp

RUN cp -p /etc/localtime /etc/localtime.UTC && \
    cp -p /usr/share/zoneinfo/Japan /etc/localtime

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
    apt-get install -y  --no-install-recommends \
    yarn \
    nodejs \
    build-essential \
    libpq-dev \
    vim \
    nginx \
    supervisor \
    mariadb-client \
    imagemagick \
    graphviz && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN gem install bundler

# yarn install Preparation
RUN npm install n -g
RUN n 12.18.4

## nginx
RUN groupadd nginx
RUN useradd -g nginx nginx
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/dev.adachin.com.conf /etc/nginx/conf.d/dev.adachin.com.conf

## supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisor/app.conf /etc/supervisor/conf.d/app.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
