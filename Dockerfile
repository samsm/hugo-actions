FROM registry.gitlab.com/pages/hugo/hugo_extended:latest

# Hugo External Dependecies
RUN apk add --update --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  py-pygments asciidoctor npm ca-certificates libc6-compat libstdc++ git go openssl tar gzip \
  && rm -rf /var/cache/apk/*

RUN npm install --unsafe-perm=true -g postcss postcss-cli autoprefixer \
  && npm install --unsafe-perm=true -g @babel/cli @babel/core @babel/preset-env

RUN wget https://github.com/jgm/pandoc/releases/download/2.9.1.1/pandoc-2.9.1.1-linux-amd64.tar.gz \
  && tar xvzf pandoc-2.9.1.1-linux-amd64.tar.gz --strip-components 1 -C /usr/local \
  && rm pandoc-2.9.1.1-linux-amd64.tar.gz \
  && mkdir /site

COPY ./docker-entrypoint.sh /entrypoint.sh

WORKDIR /site

VOLUME [ "/site" ]

EXPOSE 1313

CMD [ "/usr/bin/hugo", "-h" ]
