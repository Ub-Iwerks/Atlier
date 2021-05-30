## 1. はじめに

初めまして、10月26日からエンジニアとして勉強を始めました、あいくと申します。元々は建築学部の学生でした。学習の一区切りとして、Railsでポートフォリオを制作しました。

この記事では、成果物の概要や制作時に心掛けていた点、ポートフォリオで得た学びなど共有する目的で投稿致します。

## 2. Atlier - 作品共有型SNS
![card](https://user-images.githubusercontent.com/72424114/116229407-6dd98300-a791-11eb-94b7-a202bd3c6a3c.png)

作品共有型SNS Atlier を制作しました。

ここではアプリの概要として、主となる3つの機能を紹介します

**1. 自分の作品を記録する**
![work_post](https://user-images.githubusercontent.com/72424114/116229090-0de2dc80-a791-11eb-8425-cb67fc009554.gif)

**2. 他者の作品を調査する**
![search](https://user-images.githubusercontent.com/72424114/116229256-3d91e480-a791-11eb-9300-72ec47156d12.gif)

**3. 制作者とコミュニケーションを取る**
![comment](https://user-images.githubusercontent.com/72424114/116229195-29e67e00-a791-11eb-91a4-c2be7b969294.gif)

## 3. アプリ開発の背景と問題意識

Atlierのコンセプトは以下の2つです。

1. クリエイターに特化した情報共有の場を設ける
2. 作品の意図を正確に伝える場を提供する

これらは私が、建築学部に在学中の経験とそれに対する問題意識に基づいています。

### (1) クリエイターに特化した情報共有の場を設ける

多くの建築学生は、定期的に課題に取り組み、自主的にコンペに参加するなど制作の機会が多くあります。その度に、コンセプト構想や要件定義の為に、情報収集を行います。
そこで、**定期的に訪れる情報収集の機会を効率化・最適化できないか**、と考えたことがキッカケです。

- 他者の作品に触れることで、作品に関する洞察を得ることができる
- 自分の作品を記録することで、これまでの制作を客観的に見ることができる

これらを目的にAtlierの制作に取り組みました。

### (2) 作品の意図を正確に伝える場を提供する

建築やイラストなどの作品では、視覚的情報(画像やスケッチなど)で制作意図を伝えることが多いです。
しかし建築分野では、作品の説明における言葉の選択や文章表現にも同じくらい重点が置かれています。

そこで、**作品の特徴**や**制作意図**を**正しく他者に伝える**ことができる場を設けよう、と考えました。

## 4. 主な機能

| No. | 機能 | gem | 詳細説明 |
|:-----------|------------:|:------------:|:------------:|
| 1| ユーザー登録・ユーザー情報編集・ログイン機能       | devise        |あり|
| 2| SNS新規登録 & SNSログイン      | omniauth       ||
| 3| 作品を登録 | |あり|
| 4| 作品にカテゴリー追加| ancestry |あり|
| 5|画像アップロード機能（作品画像・ユーザーアイコン）| ActiveStorage|         |
| 6|画像のリサイズ（メイン画像とその他画像を明確に分ける）| Image_processing|         |
| 7|ユーザーフォロー機能(Ajax)| |         |
| 8|作品のいいね機能(Ajax)| |         |
| 9|作品にコメントする| |         |
| 10|検索機能（曖昧検索 & カテゴリー検索）| |あり|
| 11|通知機能| |あり|
| 12|フィード機能| ||
| 13|ページネーション機能|kaminari ||
| 14|レスポンシブ対応| | |
| 15|SEOフレンドリー| meta-tags| |


## 5. こだわりポイント

### （１）機能面で心掛けた点6つ

#### ① ユーザー登録後、パスワードを変更できる（ 機能1 ）

機能概要

- パスワード変更画面の追加
現在のパスワード・新しいパスワード・新しいパスワード(確認用)を入力することで変更可能にする

実装時に工夫した点

- deviseではデフォルトで用意されていない、ログイン後のパスワード変更画面を追加した。

- 全く新しい機能として追加するのではなく、ソースコードを読み込み、deviseのメソッドなどを用いて機能の拡張を実現した。

- 必要なものを新しく用意するのではなく、部品の再利用などを心掛けたOOPの設計思想に準じた機能実装を心掛けた。

#### ②フォームオブジェクトを用いた、複数モデルへの複数オブジェクトの同時保存（ 機能3 )

機能概要

- ユーザーは作品を投稿する際に、タイトル・メイン画像・コンセプト・説明文を記載する。

- 加えて（サブ写真・サブ画像の名前・サブ画像の説明）のセットを5つまで添付できる。

- 画像選択時には、プレビュー表示・5MB以上では選択後にエラー表示される。投稿失敗の場合は原因をエラーメッセージで表示される。

実装時に工夫したこと

- 1つのフォームで2つのモデルへオブジェクトを保存している。

- 一方のモデルは(最大)5つまで同時に保存ができる。

- 2つのモデルは1対多の関係性にあり、保存時に自動的に関連付けが付加される。

- オブジェクト保存時、エラーが発生した場合には、保存失敗とその要因をコントローラーに返すメソッドを独自に定義している。

#### ③ancestryを用いた系列列挙型モデルの実装（ 機能4 ）

機能概要

- 作品にカテゴリーを追加できる。

- サブカテゴリーに関してはjqueryにより、親カテゴリーに即した選択肢が自動的に表示される。

実装時に工夫したこと

- SQLのアンチパターンである系列列挙型モデルを用いて、RDBで階層構造を実現。

- 過去に同じ階層構造である入れ子集合モデルを実装したことがあるので、今回は異なるアンチパターンを選定した。（solidusを用いたECサイト設計時）

#### ④自作の検索機能を実装（ 機能10 ）

機能概要

- 曖昧検索：検索キーワードがタイトルかコンセプトに含まれる作品を返す

- カテゴリー検索：同一のカテゴリーに属する作品を返す。親カテゴリーのみ選択した場合は、親に選択されたカテゴリーを持つ作品を全て返す

- 2つの検索方法を用いた、詳細検索も可能。

実装時に工夫したこと

- 一度ransackを利用した経験がある為、独自のsearchメソッドを定義した。今回はフォームオブジェクトを用いて、検索条件をviewで送信されてから、検索内容に引っ掛かる作品を返すまでの一連の流れを作成した

- 曖昧検索は検索窓をヘッダーに用意し、どのページでも検索可能にする。

#### ⑤ユーザーに通知を送り、他ユーザーとの交流を促す（ 機能11 ）

機能概要

- ユーザーにいくつかのアクションが被った場合に、通知を届ける。

- 通知が確認されるまで、ヘッダーに未既読のマークが表示される。

- 通知画面にて新しい通知にはマークが表示される。

- 通知が届く条件

1. フォローされた時
2. 自分の作品にいいね or コメントされた時
3. 自分がコメントした作品に他者がコメントした時

実装時に工夫したこと

- フォロー、いいね、コメントのそれぞれの場合に対応したメソッドを定義した。(要リファクタリング)

- 通知を確認したことはコントローラーでコールバックメソッドを用いて、`get index`された場合に未確認の通知がある場合に確認済みに変更される。

#### ⑥ UI/UXに最低限気を配る

私はフロントエンドに関しては、未学習のことが多いです。しかし、それを理由にいい加減に済ませるのではなく、ユーザーの体験に影響を与える部分では最低限気を配ろうと心掛けました。

以下にその具体例をいくつか掲示します。

- 作品投稿時の画像選択においてプレビューを表示する。画像の容量が大きい場合には、保存前に選択できないように警告する。
- 作品へのリプライを送りやすい様に、メッセージアプリのUIを参考にした。
- アプリケーション全体の色合いがユーザーの作品に影響を与えない様、ベーシックな色合いを心掛けた。

これらを通して、UI/UXにおけるJavascriptの需要性を実感することができました。

### （２）開発を通して心掛けた点4つ

#### ① 開発環境をDockerで構築する

実際の開発現場で利用される技術を身につけること目的に、開発環境にDockerを取り入れました。Docker環境を構築するのは初めてであり、苦労することもありました。しかし、開発環境をコードで管理するというDockerの良さを体感することができた、と感じています。

#### ②RSpecによるテストを徹底する（TDDを意識）

エラーやミスを事前に防止することを目的に、完全とまでは行きませんが、テストを先行して作成するTDDを意識して開発を進めました。テストにはRSpecを導入しました。基本的にコントローラーのアクションとモデルのバリデーションは全てテストしてあります。
特に、独自に作成したメソッドは入念にテストを作成し、エラーが生じない様に注意を払いました。
system_specでは、ユーザーのアプリ利用に即したテストを意識しました。

#### ③Rubocopによるコードの可読性向上を図る

コードの可読性向上を図ることを目的に、rubyの静的解析ツールであるRubocopを導入しました。
Rubocopはデフォルト設定だと少しチューニングが必要になると伺い、実際の開発現場用にカスタマイズされている`gem 'rubocop-airbnb'`を採用しました。

#### ④githubでのissue管理・PRリクエスト・コミットでの文言に注意を払う

今後のチーム開発の練習を目的に、githubのissue管理を用いた開発サイクルを導入しました。
コードだけでなく、開発全体を通した一貫性を心がけること、自分が行った変更がアプリケーション全体から見てどのような意味があるのか伝わる様に心掛けました。
私は実際のエンジニアの方にコードレビューをして頂いた経験がある為、その時に指摘して頂いた「コミットメッセージ」と「PRのコメント」の内容には気を配りました。

具体的に、コミットメッセージでは1行目に行ったこと・3行目にその目的を記載しました。(以下具体例)

```terminal
Add preview function before user avatar change #10

To enable user to check how chage image
```

PRのコメントでは、今回のPRで追加・修正された機能、その際に心掛けた点・注意を向けた点に関して記載しました。

## 6. 使用した技術

フロントエンド

- HTML
- CSS
- Sass
- Bootstrap
- Javascript (jquery)

バックエンド

- Ruby 2.6.6
- Rails 6.1.3
- RSpec
- Rubocop

インフラ

- docker 3.0
- heroku
- AWS S3
- mysql 8.0

## 7. DB設計
![Atlier_ER図](https://user-images.githubusercontent.com/72424114/116229445-7cc03580-a791-11eb-8bb6-01c1a6cc4d82.png)

## 8. 振り返り

### (1) 開発を通して得た学び3つ

#### ① ソースコードを読む

新しいgemなどを扱う時、ソースコードやgithubのReadmeなどの公式な情報を優先的に触れることの大切さを学びました。

ソースコードには独自の変数やメソッドが多く、Readmeなどの解説は英語であることが多い為、解読に少し時間を要します。それでも、公式の情報に触れることの方が、間接的な情報(QiitaやStack Overflowなど)よりも、正確かつ最新であり、有益だと学びました。

#### ② ぶつかりながら進む姿勢

例外やエラーの発生を前提に開発を進めることと、それらに対する準備の大切さとを学びました。

新しい技術を取り入れる時など、「失敗やエラーが怖くて開発が進まない」ことがありました。これはエラー発生後に対応できるか分からない、ことが原因で生じていると考えました。

これらを解決する為に、例外やエラーが発生しても対応できるような体勢を整えることの大切さ（gitのbranchを切る、など）と、例外とエラーと向き合いながら開発を進める姿勢の大切さを学びました。

#### ③ 改めて感じるテストの有益さ

②と少し近いですが、エラーや例外に対する向き合うことの一つとして、TDDで開発を進めることがとても効率的であると学びました。

様々な変更を加えていくと、ある機能に対して他の機能に干渉し、エラーを発生させることがあります。それらを事前に防ぐ、またはエラーの発生に気づく為にテストはとても有益でした。テストを書くことに時間が必要ですが、テストのおかげで安心して開発を進めることができることや、エラーにいち早く対応できることは、時間をかけるだけの価値があると感じました。

### (2) 課題点 & 今後導入したいこと4つ

#### ~~① N + 1問題~~

~~動作することを主眼に開発進めてきた為、クエリ発行時にN+1問題が生じている部分が存在します。これはアプリケーションに負担を掛ける原因である為、優先的に解決したいです。~~
`gem "bullet"`を参考に、主に`includes`を用いることでN+1問題を解消しました。

#### ②Circle CIを用いた継続的デプロイ

私は一度CircleCIを用いた開発に携わった経験があります。CircleCIを用いた快適なデプロイは安定感があり、開発者の無駄を大きく省いてくれると感じました。
機能として必須ではないので、導入してきませんでした。しかし、今後開発に携わる身として、設定を含めて開発環境に導入したいです。

#### ~~③RSpecのsystem_specでJSの内容までテストする~~

~~現状では、Rspecのsystem_specを`rack_test`にしており、Javascriptを用いない状態で動作をテストしています。しかし、ユーザーの利用に近い状態でテストを走らせる為に、javascriptも操作可能な`selenium`を導入したいです。~~
RSpecの統合テスト実行環境のドライバーに`:remote_chrome`を指定することで、テスト環境にてJSやAjaxなどのMOD操作のテストを可能とした。

#### ④フロントサイドの無駄の多さ

cssの命名規則には、BEMを用いることでクラス名に統一感を持たせるよう心掛けました。
しかしながら、cssは場当たり的な対応が多く、ひどく煩雑で無駄の多いコードになっていると感じています。またJSへの理解が乏しく、JSのコードも散在しており、被りが多い状態になっています。
これらのリファクタリングを行いたいです。

## 9. おわりに

最後まで読んで頂き、本当にありがとうございました！
