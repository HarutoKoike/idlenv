# Virtual Environment for IDL

## インストール
### IDL8.7以上の場合
IDLを起動し、以下のコマンドを実行する。<br>
```
IDL> ipm, /install, 'https://github.com/HarutoKoike/idlenv'
```
### ILD8.6以前の場合
IDLのシステム変数!PACKAGE_PATHのディレクトリ　(デフォルトでは、~/.idl/idl/packages)に直接インストールする。<br>
```
cd ~/.idl/idl/packages
git clone 'https://github.com/HarutoKoike/idlenv'
```

## 使い方
1. `idl -e 'idlenv, "作成する仮想環境のディレクトリ名"'`を実行。<br>
    もしくはidlを起動し、`idlenv, 'ディレクトリ名'`を実行。
2. 指定したディレクトリに移動し、`source .activate`を実行。
3. idl_startup.proにIDL起動時の設定を記述する。
4. IDLを実行する。
5. 仮想環境から抜けるときには`deactivate`を実行する。


## 説明
activate成功後には、libと.packagesの2つのディレクトリとidl_startup.proが作成される。

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



## 仮想環境の共有・移行について
保存されたパッケージのリストをCSVファイルに書き出し、そのファイルを別の環境に持っていくことで、元の環境の再現が可能。

### freeze.pro
freeze.proは、.packageディレクトリ直下に保存された全てのパッケージの情報をCSVファイルに書き出す。 <br>
例えば、mypkgというパッケージがあるときには、'.package/mypkg/idlpackage.json'というJSONファイルを探し、 <br>
その中の"Name", "URL", "Version"という3つのフィールドを抜き出す。<br>
```
IDL> freeze`
```

### install_pkg.pro
install_pkg.proは、freeze.proで書き出したパッケージ情報のCSVファイルを読み込み、インストールを行う。<br>
このとき、"URL"フィールドが存在しない場合（パッケージがネットワークからアクセスできない場合）、インストールは行わない。<br>
"Version"フィールドが存在する場合、それに応じたバージョンをインストールする。<br>
```
IDL> install_pkg, 'requirements.csv'
```
