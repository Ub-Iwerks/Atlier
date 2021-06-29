## 0. atlier_dev

開発環境の構築手順を以下に記載します。

![開発環境](https://user-images.githubusercontent.com/72424114/123391803-56731680-d5d7-11eb-9ab0-3596397422af.png)

1. localhostの追加

```bash
sudo vim /etc/hosts
127.0.0.1 dev.atlier.work
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
/usr/bin/supervisorctl start app
```

5. [http://dev.atlier.online/](http://dev.atlier.online/)にアクセス
