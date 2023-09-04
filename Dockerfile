FROM eclipse-temurin:17 as ApiBuilder

COPY playedu-api /app

WORKDIR /app

# 编译jar包
RUN /app/mvnw -Dmaven.test.skip=true clean package

FROM node:20-alpine as NodeBuilder

COPY playedu-backend /app/backend
COPY playedu-pc /app/pc
COPY playedu-h5 /app/h5

# 编译后端
WORKDIR /app/backend
RUN npm i && VITE_APP_URL=/api/ npm run build

# 编译PC
WORKDIR /app/pc
RUN npm i && VITE_APP_URL=/api/ npm run build

# 编译H5
WORKDIR /app/h5
RUN npm i && VITE_APP_URL=/api/ npm run build

FROM eclipse-temurin:17

LABEL maintainer="0xtyz <tengyongzhi@meedu.vip>"

#使用东八区时间环境
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#安装基本组件
RUN apt update && apt install -y nginx

RUN mkdir /app

COPY --from=ApiBuilder /app/playedu-api/target/playedu-api.jar /app/app.jar

COPY --from=NodeBuilder /app/backend/dist /app/backend
COPY --from=NodeBuilder /app/pc/dist /app/frontend
COPY --from=NodeBuilder /app/h5/dist /app/h5

# 复制nginx配置文件
COPY docker/nginx/conf/nginx.conf /etc/nginx/sites-enabled/default

RUN chmod +x /app/api/start.sh

ENTRYPOINT ["/app/api/start.sh"]