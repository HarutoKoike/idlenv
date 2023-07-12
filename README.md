# Virtual Environment for IDL (>IDL8.3)

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
1. 仮想環境を作りたいディレクトリに移動する。
2. `idl -e 'idlenv, "作成する仮想環境のディレクトリ名"'`を実行。<br>
    もしくはidlを起動し、`idlenv, 'ディレクトリ名'`を実行。 <br>
    このとき、**ディレクトリ名は相対パスで指定する。**
3. 指定したディレクトリに移動し、`source bin/activate`を実行。
4. idl_startup.proにIDL起動時の設定を記述する。
5. IDLを実行する。
6. 仮想環境から抜けるときには`deactivate`を実行する。


## 作成されるディレクトリ・ファイルについて
activate成功後には、libと.packagesの2つのディレクトリとスタートアップファイルが作成される。 <br>
スタートアップファイルは、`(仮想環境のディレクトリ名)_startup.pro`となる。　<br>
activate時に、環境変数IDL_STARTUPは、作成されたスタートアップファイルになっている。

### .idlenvcfg
idlenvによってディレクトリが作成されると、作成したディレクトリに`.idlenvcfg`という設定ファイルが作られる。<br>
このファイルには、idlenvのライブラリのパスとidlのバージョンが書き込まれる。別のデバイスにフォルダを移行する場合、idlenvへのパスを書き換えないと、下記のプロシージャを使うことができないので注意。<br>
※ 2022/12/25 activate時に'~/.idl/idl/packages/idlenv'にパスを通すように変更したので、idlenvが適切な場所にインストールされていれば.idlenvcfgを書き換える必要なし。

### .package
.packageはIDLのパッケージを保存するためのディレクトリ。<br>
システム変数!PACKAGE_PATH(もしくは、環境変数$IDL_PACKAGE_PATH)により指定され、`<IDL_DEFAULT>`に含まれる事になる。<br>
IDL Package Manager(IPM)によりインストールされるパッケージはここへ保存される。<br>

IPMについて　https://www.l3harrisgeospatial.com/docs/ipm.html <br>
IDL_PACKAGE_PATHについて https://www.l3harrisgeospatial.com/docs/prefs_directory.html#PACKPATH 




## デフォルトのスタートアップ処理
新たに仮想環境を作る際に、すべての環境で共通して行うスタートアップ処理を記載したファイル名を、
環境変数`$IDL_STARTUP_DEFAULT`に指定しておくことで、新しく仮想環境を作った時にそのファイルに
記載された処理が作成されたスタートアップファイルにそのままコピーされる。


## 仮想環境の共有・移行
保存されたパッケージのリストをCSVファイルに書き出し、そのファイルを別の環境に持っていくことで、元の環境の再現が可能。

### freeze.pro
freeze.proは、.packageディレクトリ直下に保存された全てのパッケージの情報をCSVファイルに書き出す。 <br>
例えば、mypkgというパッケージがあるときには、'.package/mypkg/idlpackage.json'というJSONファイルを探し、 <br>
その中の"Name", "URL", "Version"という3つのフィールドを抜き出す。<br>
全てのパッケージを探索して情報を抜き出し、`requirements.csv`というファイル名で書き出す。<br>
```
IDL> freeze
```

### install_pkg.pro
install_pkg.proは、freeze.proで書き出したパッケージ情報のCSVファイルを読み込み、インストールを行う。<br>
このとき、"URL"フィールドが存在しない場合（パッケージがネットワークからアクセスできない場合）、インストールは行わない。<br>
"Version"フィールドが存在する場合、それに応じたバージョンをインストールする。<br>
```
IDL> install_pkg, 'requirements.csv'
```


## 自動コンパイルの回避
exclude_pathプロシージャにより、特定のディレクトリ以下のプロシージャは自動コンパイルされないようにすることができる。実行することはないが残しておきたいプログラムを、適当なフォルダにまとめておき、そのフォルダを指定することで勝手にコンパイル・実行されないようにすることができる。プロシージャを更新して、古いものと同名の名前で保存したりする際に、衝突が起きることを防ぐことができる。
recursiveキーワードを指定することで、指定ディレクトリ以下の全てのディレクトリを再帰的に含めることができる。
```
exclude_path, './hoge', /recursive
```
