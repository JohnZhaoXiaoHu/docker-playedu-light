## PlayEdu Light Docker 构建方案

本套方案将 API + PC 前台 + H5 前台 + 后台管理 四个整合在一个镜像当中，适用于轻量级客户。

### 使用官方镜像

在命令行中执行：

> 本项目提供 `linux/amd64` 的 platform 运行。如果您是 `linux/arm64` 的话请将 `playedu/light` 修改为 `playedu/light-arm64` 。

```
docker run -d -p 9700:80 -p 9800:9800 -p 9801:9801 -p 9900:9900 --name playedu-light \
  -e DB_HOST=数据库host \
  -e DB_PORT=数据库端口 \
  -e DB_NAME=数据库名 \
  -e DB_USER=数据库用户 \
  -e DB_PASS=数据库密码 \
  -e REDIS_HOST=Redis的host \
  -e REDIS_PORT=Redis的端口 \
  -e REDIS_PASS=redis的密码 \
  -e SA_TOKEN_JWT_SECRET_KEY=随机英文+数字的字符串 \
  registry.cn-hangzhou.aliyuncs.com/playedu/light:1.2.2
```

跑起来之后，可以通过下面的链接访问前后台：

| 端口         | 地址                       |
| ------------ | -------------------------- |
| API 服务     | `http://你的服务器IP:9700` |
| 学员 PC 界面 | `http://你的服务器IP:9800` |
| 学员 H5 界面 | `http://你的服务器IP:9801` |
| 后台管理     | `http://你的服务器IP:9900` |

### 自己动手

- API 程序 `package` 之后，将 `jar` 包复制到 `api` 目录下，并重新命名为 `app.jar`
- PC 界面程序 build 之后（`VITE_APP_URL=/api/` 应该这样设置），将 `dist` 目录复制到本项目的根目录，然后重命名为 `frontend`
- 后台界面程序 build 之后（`VITE_APP_URL=/api/` 应该这样设置），将 `dist` 目录复制到本项目的根目录，然后重命名为 `backend`

之后，在本项目目录命令执行：

```
docker build --platform linux/amd64 -t playedu-light .
```

> 如果是编译 arm 平台运行镜像的话，请将上述命令的 `linux/amd64` 更换为 `linux/arm64` 。

执行完毕之后，可运行下面命令将 PlayEdu 服务跑起来：

```
docker run -d -p 9700:80 -p 9800:9800 -p 9801:9801 -p 9900:9900 --name playedu-local \
  -e DB_HOST=数据库host \
  -e DB_PORT=数据库端口 \
  -e DB_NAME=数据库名 \
  -e DB_USER=数据库用户 \
  -e DB_PASS=数据库密码 \
  -e REDIS_HOST=Redis的host \
  -e REDIS_PORT=Redis的端口 \
  -e REDIS_PASS=redis的密码 \
  -e SA_TOKEN_JWT_SECRET_KEY=随机英文+数字的字符串 \
  playedu-light
```

跑起来之后，可以通过下面的链接访问前后台：

| 端口         | 地址                       |
| ------------ | -------------------------- |
| API 服务     | `http://你的服务器IP:9700` |
| 学员 PC 界面 | `http://你的服务器IP:9800` |
| 学员 H5 界面 | `http://你的服务器IP:9801` |
| 后台管理     | `http://你的服务器IP:9900` |
