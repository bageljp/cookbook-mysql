#
# Cookbook Name:: mysql
# Recipe:: server
#
# Copyright 2013, bageljp
#
# All rights reserved - Do Not Redistribute
#

%w(
  mysql55
  mysql55-common
  mysql55-devel
  mysql55-libs
  mysql55-server
).each do |pkg|
  package pkg
end

template "/etc/my.cnf" do
  owner "root"
  group "root"
  mode 00644
  source "my_server.cnf.erb"
  notifies :restart, 'service[mysqld]'
end

template "/etc/logrotate.d/mysqld" do
  owner "root"
  group "root"
  mode 00644
  source "logrotate_mysqld.erb"
end

service 'mysqld' do
  supports :status => true, :restart => true, :reload => false
  action [ :enable, :start ]
end
