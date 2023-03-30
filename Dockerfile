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

RUN mkdir /home/$USER/.ssh
RUN chown "$USER:$USER" /home/$USER/.ssh
RUN chmod 700 /home/$USER/.ssh
COPY --chown="$USER:$USER" --chmod=600 ssh/* /home/$USER/.ssh/

WORKDIR /home/$USER

CMD ["/bin/bash"]
