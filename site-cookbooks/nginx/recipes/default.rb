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

node["nginx"]["virtual"].each do |virtual|
  name = virtual[0]
  log_dir = "/home/vagrant/www/#{name}/logs"
  docroot = "/home/vagrant/www/#{name}/public"

  [log_dir, docroot].each do |dir|
    log "#{dir} hello, Chef"
    directory dir do
      owner "vagrant"
      group "vagrant"
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
      :log_dir => log_dir,
      :docroot => docroot,
    })
    owner "root"
    group "root"
    mode 0644
    notifies :reload, 'service[nginx]'
  end
end

