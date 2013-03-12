Tinymd
======

# install

<pre>
    git clone git://github.com/k1complete/tinymd.git
    cd tinymd
    mix deps.get
    mix compile
    # create your contents...
    # emacs web/template/foo.html.md
    # run dynamo!
    MIX_ENV=prod mix server
</pre>

# for heroku deploy

herokuは$PORT環境変数をアプリケーションの接続に使います。
mix_task_heroku がmix heroku タスクを用意してdynamoを
$PORTを使ってlistenするようにします。


# 苦労した点
* cowboyのバージョンは最新だとdynamoが対応していない
* ranchのバージョンは最新だとry
* dynamoのmix serverだとherokuのPORT環境変数を使ってのlistenが
出来無い。なのでmix_task_herokuを作成するはめに。
* erlmarkdownはUpper256なUTF-8だとbad argになる(なのでpull requestした)

# 良かった点
* mix.lockがなんのためにあるのか判った
* mix.exsのdepsでのrefやbranchが何のためにry


# content management

* web/template/配下に拡張子mdで記述してください。
* 余計なバックアップファイルを削除してください。
 これを怠るとビルド時にハンドラが見付からないとエラーになります。
* herokuへのデプロイはgit commit,  and git push heroku


# customize

* web/routers/application_router.ex を参照してください。ベースURIを変更する際にはここです。

#  new template rendering handler

* 他のテンプレートエンジンを作るには lib/dynamo/templates/*.exを参照してください。
* Dynamo.Templates.Handlerビヘイビアを使用して、以下の二つの関数を実装するだけでOKです。
* compile/3: ビルド時に呼ばれ、各テンレートをelixirモジュールに
  コンパイルします。(compile_on_demand: trueにすると
  必要に応じてコンパイルされます)
* render/4: ページアクセス時に呼ばれ、コンパイルされたモジュール
  を呼び出します。
