FROM debian

ARG GITLAB_ADDR

RUN apt-get update -q && apt-get install -y curl vim ca-certificates openssh-server postfix && \
	curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh| bash && \
	EXTERNAL_URL="$GITLAB_ADDR" apt-get install gitlab-ce

EXPOSE 22 80 443
