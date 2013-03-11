Tinymd
======

# install
<pre>
    mix get.deps
    mix compile
    # create your contents...
    # emacs web/template/foo.html.md
    # run dynamo!
    MIX_ENV=prod mix server
    # visit http://localhost:8080/md/foo.html...
</pre>

# for heroku deploy
   herokuは$PORT環境変数をアプリケーションの接続に使います。
   mix_task_heroku がmix heroku タスクを用意してdynamoを
   $PORTを使ってlistenするようにします。
<pre>
    (... setup heroku apps environment)
    echo 'web: MIX_ENV=prod mix heroku -p=$PORT' > Procfile
</pre>

# content management
  * web/template/配下に拡張子mdで記述してください。
  * 余計なバックアップファイルを削除してください(ex. ...#, ...~ etc.)。
    これを怠るとビルド時にハンドラが見付からないとエラーになります。
  * git commit,  and push heroku

# customize
  * web/routers/application_router.ex を参照してください
    ベースURIを変更する際にはここです。

#  new template rendering handler
  * 他のテンプレートエンジンを作るには lib/dynamo/templates/*.exを
   参照してください。
  * Dynamo.Templates.Handlerビヘイビアを使用して、
    以下の二つの関数を実装するだけでOKです。
       * compile/3: ビルド時に呼ばれ、各テンレートをelixirモジュールに
                    コンパイルします。(compile_on_demand: trueにすると
                    必要に応じてコンパイルされます)
       * render/4: ページアクセス時に呼ばれ、コンパイルされたモジュール
                    を呼び出します。
