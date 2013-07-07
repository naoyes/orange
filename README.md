# Orange

## How To Use

### Vagrant でマシンを準備

```
$ mkdir /some/where
$ vagrant init centos
$ vagrant up
$ vagrant ssh-config --host orange>> ~/.ssh/config
```
### レシピの取得

```
$ git clone https://github.com/naoyes/orange.git chef-repo
```

### レシピの生成

```
$ cd chef-repo
$ bundle --path vendor/bundle
$ bundle exec berks --path cookbooks
```

### レシピの適用

```
$ knife solo prepare orange
$ knife solo cook orange
```
