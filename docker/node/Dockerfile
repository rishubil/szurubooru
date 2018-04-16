FROM node:boron

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /yfbooru
WORKDIR /yfbooru

VOLUME /yfbooru
ENTRYPOINT ["/entrypoint.sh"]
