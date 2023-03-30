ARG VERSION=latest

FROM TEMPLATE:$VERSION

ARG USER
ARG PASSWORD
ARG EMAIL
ARG FULLNAME

RUN \
    su $USER -c 'git config --global user.email "$EMAIL"'; \
    su $USER -c 'git config --global user.name "$FULLNAME"'

WORKDIR /home/$USER

CMD ["/bin/sh"]
