# Virtual Environment for IDL


## 使い方
1. `idl -e 'idlenv, "作成する仮想環境のディレクトリ名"'`を実行。<br>
    もしくはidlを起動し、`idlenv, 'ディレクトリ名'`を実行。
2. 指定したディレクトリに移動し、`source .activate`を実行。
   カレントティレクトリにlibと.packagesの2つのディレクトリと
   idl_startup.proが作成される。
3. idl_startup.proにIDL起動時の設定を記述する。
4. IDLを実行する。
5. 仮想環境から抜けるときには`deactivate`を実行する。


## 説明
### .packageについて
.packageはIDLのパッケージを保存するためのディレクトリ。<br>
境変数IDL_PACKAGE_PATHにより指定されている。IDL Package Manager(IPM)によりインストールされるパッケージはここへ保存される。<br>

IPMについて　https://www.l3harrisgeospatial.com/docs/ipm.html <br>
IDL_PACKAGE_PATHについて https://www.l3harrisgeospatial.com/docs/prefs_directory.html#PACKPATH 



### libについて
libは各ユーザーの作成したIPMで管理されていないライブラリを保存するディレクトリ。<br>
デフォルトの設定ではこのディレクトリにパスが通っていないので、IDL起動時に!PATH変数に書き加える形でパスを通す。

例えば、lib-Aというディレクトリにパスを通す場合、idl_startup.proに次のような記述を加える。 
```{idl}
  !PATH+=':~/vidl/lib/lib-A'
```
lib-A以下全てのディレクトリに再帰的にパスを通す場合、パスの頭に"+"をつける。
```{idl}
  !PATH+=':+~/vidl/lib/lib-A'
```
