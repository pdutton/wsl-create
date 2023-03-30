ARG VERSION=bullseye

FROM golang:$VERSION

ARG USER
ARG PASSWORD
ARG EMAIL
ARG FULLNAME
ARG GO_VERSION
ARG GO_ARCH=amd64

ADD https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz /tmp

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils sudo
RUN useradd -c "$FULLNAME" --shell /bin/bash --create-home --user-group --groups sudo $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "[user]" > /etc/wsl.conf
RUN echo "default=$USER" >> /etc/wsl.conf
RUN su $USER -c 'git config --global user.email "$EMAIL"'
RUN su $USER -c 'git config --global user.name "$FULLNAME"'

RUN mkdir /home/$USER/.ssh
RUN chown "$USER:$USER" /home/$USER/.ssh
RUN chmod 700 /home/$USER/.ssh
COPY --chown="$USER:$USER" --chmod=600 ssh/* /home/$USER/.ssh/

RUN tar -C /usr/local -xf /tmp/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz
RUN rm /tmp/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz
RUN mv /usr/local/go /usr/local/go${GO_VERSION}
RUN ln -s /usr/local/go${GO_VERSION} /usr/local/go
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> /home/$USER/.profile

WORKDIR /home/$USER

CMD ["/bin/sh"]
