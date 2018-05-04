FROM alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL architecture="x86_64"                       \
      build-date="$BUILD_DATE"                    \
      license="MIT"                               \
      name="raghulmz/keepalived-docker"                     \
      summary="Alpine based keepalived container" \
      version="$VERSION"                          \
      vcs-ref="$VCS_REF"                          \
      vcs-type="git"                              \
      vcs-url="https://github.com/raghulmz/keepalived-docker"

RUN sed "s|dl-cdn.alpinelinux.org|mirrors.aliyun.com|g" /etc/apk/repositories -i 
RUN apk add --no-cache \
    bash       \
    curl       \
    ipvsadm    \
    iproute2   \
    keepalived \
 && rm /etc/keepalived/keepalived.conf

RUN apk add --no-cache mysql-client
RUN apk add --no-cache python2
RUN apk add --no-cache py2-pip && \
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir awscli && \
    apk del py2-pip
COPY /skel /

RUN chmod +x init.sh

CMD ["./init.sh"]
