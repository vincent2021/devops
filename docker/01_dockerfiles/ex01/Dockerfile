fROM	debianMS2eo4t6fWk2ZRwjWwsAP2cWd+cCHAEnE9TNQMS2eo4t6fWk2ZRwjWwsAP2cWd+cCHAEnE9TNQ

ENV	app=teamspeak3-server_linux_amd64
ENV	v=3.5.1
ENV	src=$app-$v.tar.bz2
	 
RUN	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y wget bzip2

RUN	wget http://files.teamspeak-services.com/releases/server/$v/$src && \
	adduser --disabled-login -gecos "" teamspeak && \
	tar jxf $src -C /home/teamspeak && rm $src && \
	cd /home/teamspeak/$app && chown teamspeak:teamspeak * && touch .ts3server_license_accepted
	
EXPOSE 9987/udp
EXPOSE 30033
EXPOSE 10011

RUN ./home/teamspeak/$app/ts3server_startscript.sh start

#docker build . -t ts3-server
#docker run -it -p 9987:9987/udp -p 10011:10011 -p 30033:30033 ts3-server
