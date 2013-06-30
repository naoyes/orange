#
# Cookbook Name:: php54
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w(php54 php54-mbstring php54-pecl-xdebug).each do |package|
  yum_package package do
    action :install
  end
end

file "/etc/php.d/timezone.ini" do
  owner "root"
  group "root"
  mode "0644"
  content "[Date]\ndate.timezone = '#{node["php"]["timezone"]}'\n"
  action :create_if_missing
end
