FROM debian

RUN apt-get update -q && apt-get install -y wget curl vim ca-certificates openssh-server postfix

RUN wget https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh && \
	 chmod +x script.deb.sh && ./script.deb.sh && apt-get install -y gitlab-ce

EXPOSE 22 80 443

ENTRYPOINT (/opt/gitlab/embedded/bin/runsvdir-start &) && gitlab-ctl reconfigure && tail -f /dev/null
