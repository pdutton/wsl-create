ARG VERSION=alpine

FROM golang:$VERSION

ARG USER
ARG PASSWORD
ARG EMAIL
ARG FULLNAME

RUN apk update
RUN apk add --no-cache make git openssh-client gcc libc-dev doas doas-sudo-shim
RUN adduser -g "$FULLNAME" -s /bin/ash -D $USER
RUN addgroup $USER wheel
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo 'permit persist :wheel' >> /etc/doas.d/doas.conf
RUN echo -e "[user]\ndefault=$USER" > /etc/wsl.conf
RUN su $USER -c 'git config --global user.email "$EMAIL"'
RUN su $USER -c 'git config --global user.name "$FULLNAME"'

RUN mkdir /home/$USER/.ssh
RUN chown "$USER:$USER" /home/$USER/.ssh
RUN chmod 700 /home/$USER/.ssh
COPY --chown="$USER:$USER" --chmod=600 ssh/* /home/$USER/.ssh/

WORKDIR /home/$USER

CMD ["/bin/ash"]
