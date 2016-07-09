#
# Cookbook Name:: mysql
# Recipe:: repo
#
# Copyright 2013, bageljp
#
# All rights reserved - Do Not Redistribute
#

remote_file "/usr/local/src/#{node['mysql']['community']['repo']}" do
  owner "root"
  group "root"
  mode 00644
  source "#{node['mysql']['dwicommunity']['url']}#{node['mysql']['community']['repo']}"
end

package "mysql-community-release" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/usr/local/src/#{node['mysql']['community']['repo']}"
end

