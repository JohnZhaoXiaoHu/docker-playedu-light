FROM eclipse-temurin:17-alpine

LABEL maintainer="0xtyz <tengyongzhi@meedu.vip>"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

# 安装基本组件
RUN apk update && apk add nginx

RUN mkdir /app

# Copy代码
COPY frontend /app/frontend
COPY backend /app/backend
COPY api /app/api
COPY conf/nginx.conf /etc/nginx/http.d/default.conf

RUN chmod +x /app/api/start.sh

ENTRYPOINT ["/app/api/start.sh"]