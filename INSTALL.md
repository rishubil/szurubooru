YFbooru는 구동을 위해 `docker`와 `docker-compose`, `traefik`이 필요합니다.

### 설정
`config.yaml.dist` 파일을 복사하여 `config.production.yaml` 파일을 생성하고 적절히 수정합니다.

`docker-compose.traefik-production.yml` 파일을 복사하여 `docker-compose.yml` 파일을 생성하고 적절히 수정합니다.

### 초기화

```console
user@host:~$ sudo sh scripts/init.sh
```

### traefik 설치
[Traefik](https://traefik.io/)의 문서를 참조하여 적절한 방법으로 Traefik 서버를 구동합니다.
해당 서버에는 https 엔드포인트와 해당 엔드포인트에 대한 인증서가 설정되어 있어야 합니다.


### 서비스 실행
```console
user@host:~$ sudo docker-compose up
```

### 개발 설정

`config.yaml.dist` 파일을 복사하여 `config.dev.yaml` 파일을 생성하고 적절히 수정합니다.
`docker-compose.traefik-dev.yml` 파일을 복사하여 `docker-compose.yml` 파일을 생성하고 적절히 수정합니다.

이후는 일반 서버 실행과 동일합니다.
