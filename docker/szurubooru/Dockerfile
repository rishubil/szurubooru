FROM python:3.5-jessie

RUN sed -i -- 's/deb\.debian\.org/mirror.kakao.com/g' /etc/apt/sources.list
RUN echo 'deb http://mirror.kakao.com/debian jessie-backports main' >> /etc/apt/sources.list
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /yfbooru/server/szurubooru

RUN addgroup --gid 1000 yfbooru
RUN adduser --disabled-login --ingroup yfbooru --gecos '' --uid 1000 yfbooru
RUN chown -R yfbooru:yfbooru /yfbooru

COPY ./server/requirements.txt /yfbooru/server/requirements.txt
WORKDIR /yfbooru/server
RUN pip3 install --no-cache-dir -r requirements.txt  -i http://mirror.kakao.com/pypi/simple --trusted-host mirror.kakao.com
RUN pip3 install --no-cache-dir gunicorn  -i http://mirror.kakao.com/pypi/simple --trusted-host mirror.kakao.com

USER yfbooru
VOLUME /yfbooru
EXPOSE 6666
ENTRYPOINT ["gunicorn", "szurubooru.facade:app", "-b", "0.0.0.0:6666"]
