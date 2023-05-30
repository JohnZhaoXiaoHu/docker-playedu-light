#!/bin/sh

nginx

java -jar /app/api/app.jar --spring.profiles.active=prod --spring.datasource.url="jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME}?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false" --spring.datasource.username=${DB_USER} --spring.datasource.password=${DB_PASS} --spring.data.redis.host=${REDIS_HOST} --spring.data.redis.port=${REDIS_PORT} --spring.data.redis.password=${REDIS_PASS} --minio.access-key=${MINIO_USER} --minio.secret-key=${MINIO_PASS} --minio.end-point=${MINIO_END_POINT} --minio.bucket=${MINIO_BUCKET} --minio.domain=${MINIO_DOMAIN}