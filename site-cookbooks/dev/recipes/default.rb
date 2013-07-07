#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "vim" do
  action :install
end

package "screen" do
  action :install
end

home_dir = node["general"]["home_dir"]
dotfiles = "#{home_dir}/dotfiles"

git dotfiles do
  repository "git://github.com/naoyes/dotfiles"
  reference "master"
  action :sync
  user node["general"]["user"]
  group node["general"]["group"]
end

git "#{dotfiles}/.vim/bundle/neobundle.vim" do
  repository "git://github.com/Shougo/neobundle.vim"
  reference "master"
  action :sync
  user node["general"]["user"]
  group node["general"]["group"]
end

[".bash_profile", ".vim", ".vimrc", ".screenrc"].each do |name|
  link "#{home_dir}/#{name}" do
    to "#{dotfiles}/#{name}"
    user node["general"]["user"]
    group node["general"]["group"]
  end
end
