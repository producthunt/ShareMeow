FROM ruby:2.5.3-alpine
LABEL maintainer="dev+sharemeow@producthunt.com"

RUN apk add --no-cache \
      dbus \
      fontconfig \
      gcc \
      git \
      libc-dev \
      make \
      ttf-freefont \
      xvfb \
    && apk add --no-cache -X http://dl-3.alpinelinux.org/alpine/edge/testing/ wkhtmltopdf

WORKDIR /app/

ADD Gemfile* /app/

RUN bundle install --deployment --without development test \
    && rm -rf ~/.bundle/cache

ADD . /app/

ENV RACK_ENV production
ENV DISPLAY=:0.0
ENV PORT 80
CMD Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & bundle exec puma -C config/puma.rb
