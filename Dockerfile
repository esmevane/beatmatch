FROM dockerfile/nodejs

MAINTAINER Joseph McCormick, esmevane@gmail.com

RUN npm install -g grunt-cli

WORKDIR /home/beatmatch

ADD package.json /home/beatmatch/package.json
RUN npm install

ADD . /home/beatmatch

ENV NODE_ENV development

EXPOSE 9001

ENTRYPOINT grunt serve
