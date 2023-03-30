ARG VERSION=9

FROM rockylinux:$VERSION

ARG USER
ARG PASSWORD
ARG EMAIL
ARG FULLNAME

RUN dnf upgrade -y
RUN dnf group install -y 'Development Tools'
RUN dnf install -y git sudo
RUN useradd -c "$FULLNAME" -s /bin/bash --user-group --groups wheel $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo -e "[user]\ndefault=$USER" > /etc/wsl.conf
RUN su $USER -c 'git config --global user.email "$EMAIL"'
RUN su $USER -c 'git config --global user.name "$FULLNAME"'

WORKDIR /home/$USER

CMD ["/bin/bash"]
