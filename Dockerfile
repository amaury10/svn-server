
FROM phusion/baseimage:0.9.11


MAINTAINER amaury10

RUN apt-get update && \
#DEBIAN_FRONTEND=noninteractive apt-get install -y \
#wget \
#python \
#xdg-utils \
#ImageMagick && \

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
	org.label-schema.docker.cmd="docker run --detach --publish 3690:3690 --volume $PWD:/var/opt/svn amaury10/svn-server" \
	org.label-schema.description="SVN Server" \
	org.label-schema.name="svn-server" \
	org.label-schema.schema-version="1.0" \
	org.label-schema.url="https://subversion.apache.org" \
	org.label-schema.vcs-ref=$VCS_REF \
	org.label-schema.vcs-url="https://github.com/amaury10/svn-server" \
	org.label-schema.vendor="amaury10" \
	org.label-schema.version="1.0.0"
	
CMD [ "/usr/bin/svnserve", "--daemon", "--foreground", "--root", "/var/opt/svn" ]

EXPOSE 3690

HEALTHCHECK CMD netstat -ln | grep 3690 || exit 1

VOLUME [ "/var/opt/svn" ]

WORKDIR /var/opt/svn

RUN sed -i -e "s/v[[:digit:]]\.[[:digit:]]/edge/g" /etc/apk/repositories \
	&& apk add --no-cache subversion==1.10.0-r0