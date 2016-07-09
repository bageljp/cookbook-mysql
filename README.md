What's ?
===============
chef で使用する MySQL の cookbook です。

Usage
-----
cookbook なので berkshelf で取ってきて使いましょう。

* Berksfile
```ruby
source "https://supermarket.chef.io"

cookbook "mysql", git: "https://github.com/bageljp/cookbook-mysql.git"
```

```
berks vendor
```

#### Role and Environment attributes

* sample_role.rb
```ruby
override_attributes(
  "mysql" => {
    "log_rotate" => "31",
    "community" => {
      "install_flavor" => "rpm",
      "url" => "https://s3-ap-northeast-1.amazonaws.com/custom-mysql-rpm-archive/chef/"
    },
    "root_password" => "root_password"
  }
)
```

Recipes
----------

#### mysql::default
serverとclientを別レシピにしたので設定ファイルを配置するくらい。

#### mysql::server
yumによる MySQL-server のインストールと設定。

#### mysql::client
yumによる MySQL-client のインストールと設定。

#### mysql::repo
community版のリポジトリをインストール。

#### mysql::community_server
community版の MySQL-server をインストール。  
リポジトリを入れてyumでインストールするパターンと、rpmを直接インストールする2パターンがある。  
どうもyumで入るrpmと、公開されているrpmが違うみたいなのでお好きな方を。

#### mysql::community_client
community版の MySQL-client をインストール。  
リポジトリを入れてyumでインストールするパターンと、rpmを直接インストールする2パターンがある。  
どうもyumで入るrpmと、公開されているrpmが違うみたいなのでお好きな方を。

#### mysql::secure_installation_5.5
MySQL 5.5系の MySQL-server インストール後に実行する secure_installation 。

#### mysql::secure_installation_5.6
MySQL 5.6系の MySQL-server インストール後に実行する secure_installation 。

Attributes
----------

主要なやつのみ。

#### mysql::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['mysql']['root_password']</tt></td>
    <td>string</td>
    <td>MariaDBのrootユーザのパスワード。</td>
  </tr>
  <tr>
    <td><tt>['mysql']['community']['url']</tt></td>
    <td>string</td>
    <td>community版をrpmでインストールする場合にrpmが置いてあるURL。</td>
  </tr>
</table>

