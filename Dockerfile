FROM eclipse-temurin:17

LABEL maintainer="0xtyz <tengyongzhi@meedu.vip>"

#使用东八区时间环境
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#安装基本组件
RUN apt update && apt install -y nginx

RUN mkdir /app

#Copy代码
COPY frontend /app/frontend
COPY backend /app/backend
COPY h5 /app/h5
COPY api /app/api
COPY conf/nginx.conf /etc/nginx/sites-enabled/default

RUN chmod +x /app/api/start.sh

ENTRYPOINT ["/app/api/start.sh"]