FROM	ruby:2.3.0

RUN	apt-get update && apt-get upgrade -y && apt-get install -y build-essential sqlite3 nodejs
RUN	gem install rails && gem install bundler -v 1.0.0 && mkdir /opt/app

ONBUILD COPY hw /opt/app
ONBUILD WORKDIR /opt/app

ONBUILD RUN bundle install
