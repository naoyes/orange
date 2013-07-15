#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "nginx" do
  action :install
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

template "nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[nginx]'
end

# http://stackoverflow.com/a/6796648 にあるとおり
# アクセス対象のファイルのすべての親ディレクトリが"x"パーミッションを持たなければならないため
home_dir = node["general"]["home_dir"]
directory home_dir do
  mode 0701
end

web_dir = "#{home_dir}/www"
directory web_dir do
  user node["general"]["user"]
  group node["general"]["group"]
  action :create
end

node["nginx"]["virtual"].each do |virtual|
  name = virtual[0]

  app_dir = "#{web_dir}/#{name}"
  directory app_dir do
    user node["general"]["user"]
    group node["general"]["group"]
    action :create
  end

  dirs = ["logs", "app"]
  dirs.each do |dir|
    directory "#{app_dir}/#{dir}" do
      user node["general"]["user"]
      group node["general"]["group"]
      recursive true
      mode 0755
      action :create
    end
  end

  template "virtual.conf" do
    path "/etc/nginx/conf.d/#{name}.virtual.conf"
    source "virtual.conf.erb"
    variables ({
      :name => name,
      :log_dir => "#{app_dir}/logs",
      :docroot => "#{app_dir}/app/public",
    })
    owner "root"
    group "root"
    mode 0644
    notifies :reload, 'service[nginx]'
  end
end

