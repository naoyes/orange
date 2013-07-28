#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
yum_package "git18 >= 1.8.3.1-1.ius.el6" do
  action :install
end
