# Orange

## How To Use

### Vagrant でマシンを準備

```
$ mkdir /some/where
$ cd /some/where
$ vagrant init centos
```

### 生成された Vagrantfile を変更

```diff
+ config.vm.network :private_network, ip: "192.168.33.10"
```

### レシピの取得

```
$ git clone https://github.com/naoyes/orange.git chef-repo
```

### レシピの生成

```
$ cd ./chef-repo
$ bundle --path vendor/bundle
$ bundle exec berks --path cookbooks
```

### 仮想マシンの起動

```
$ vagrant up
$ vagrant ssh-config --host orange >> ~/.ssh/config
```

### レシピの適用

```
$ knife solo prepare orange
$ knife solo cook orange
```

### 開発開始

```
$ ssh orange
```
