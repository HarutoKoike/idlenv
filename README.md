# Virtual Environment for IDL


## 使い方
1. 仮想環境となるディレクトリを作り、そこに.activateファイルを置く。
2. source .activateを実行。
   カレントティレクトリにlibと.packageの2つのディレクトリと
   idl_startup.proが作成される。
3. idl_startup.proにIDL起動時の設定を記述する。
4. IDLを実行する。


## .packageディレクトリについて
.packageディレクトリはIDLのパッケージを保存するためのディレクトリ。
境変数IDL_PACKAGE_PATHにより指定されている。IDL Package Manager(IPM)
によりインストールされるパッケージはここへ保存される。
IPMについて　https://www.l3harrisgeospatial.com/docs/ipm.html
IDL_PACKAGE_PATHについて https://www.l3harrisgeospatial.com/docs/prefs_directory.html#PACKPATH 


## libディレクトリについて
libは各ユーザーの作成したIPMで管理されていないライブラリを保存する場所。
デフォルトの設定ではこのディレクトリにパスは通っていないので、
IDLにおいて!PATH変数に書き加える形でパスを通す。

例lib-Aというディレクトリにパスを通す場合 
```{idl_startup.pro}
  !PATH+=':+~/vidl/lib/lib-A'
```

