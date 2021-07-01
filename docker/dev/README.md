## 0. 開発環境構築手順

開発環境の構築手順を以下に記載します。

![開発環境構成図](https://user-images.githubusercontent.com/72424114/124074758-ec4aed80-da7e-11eb-8a76-48a2f8a2f35a.png)

1. localhostの追加

```bash
sudo vim /etc/hosts
127.0.0.1 dev.atlier.online
```

2. `.env` ファイルの追加

```
MYSQL_HOST="db"
MYSQL_NAME="app"
MYSQL_USERNAME="root"
MYSQL_PASSWORD="password"
```

3. dockerコンテナの立ち上げ

```bash
cd docker/dev
docker-compose up -d
```

4. コンテナに入り、アプリケーションサーバーを立ち上げる

```bash
docker exec -it atlier_dev bash

bundle install
rails db:migrate
rails assets:precompile
/usr/bin/supervisorctl start app
```

5. [http://dev.atlier.online/](http://dev.atlier.online/)にアクセス
