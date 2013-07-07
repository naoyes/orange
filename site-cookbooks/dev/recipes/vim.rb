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

home_dir = node["general"]["home_dir"]

git "#{home_dir}/dotfiles" do
  repository "https://github.com/naoyes/dotfiles"
  reference "master"
  action :sync
end
