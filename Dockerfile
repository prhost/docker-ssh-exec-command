FROM alpine:3.4
MAINTAINER kallef Alexandre <prhost@prhost.com.br>
RUN apk add --no-cache openssh

RUN mkdir -p /entrypoint
COPY ./setup-ssh.sh /entrypoint/setup-ssh-entrypoint
RUN chmod +x /entrypoint/setup-ssh-entrypoint
ENTRYPOINT sh /entrypoint/setup-ssh-entrypoint