ARG VERSION=latest

FROM TEMPLATE:$VERSION

ARG USER
ARG PASSWORD
ARG EMAIL
ARG FULLNAME

RUN echo -e "[user]\ndefault=$USER" > /etc/wsl.conf
RUN su $USER -c 'git config --global user.email "$EMAIL"'
RUN su $USER -c 'git config --global user.name "$FULLNAME"'

RUN mkdir /home/$USER/.ssh
RUN chown "$USER:$USER" /home/$USER/.ssh
RUN chmod 700 /home/$USER/.ssh
COPY --chown="$USER:$USER" --chmod=600 ssh/* /home/$USER/.ssh/

WORKDIR /home/$USER

CMD ["/bin/sh"]
