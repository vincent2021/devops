FROM	ruby

RUN	apt-get update && apt-get upgrade -y \
	&& apt-get install -y build-essential sqlite3 nodejs \

RUN	gem install rails && gem install bundler \
	&& mkdir /opt/app

WORKDIR /opt/app

ONBUILD RUN app /opt/app

ONBUILD RUN bundle install
