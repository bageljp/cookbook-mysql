#
# Cookbook Name:: mysql
# Recipe:: community_server
#
# Copyright 2013, bageljp
#
# All rights reserved - Do Not Redistribute
#

case node['mysql']['community']['install_flavor']
when 'yum'
  # yum
  include_recipe 'mysql::repo'

  %w(
    mysql-community-server
    mysql-community-common
    mysql-community-devel
  ).each do |pkg|
    package pkg do
      action :install
    end
  end
when 'rpm'
  # rpm
  %w(
    MySQL-server
    MySQL-devel
  ).each do |pkg|
    package_name = "#{pkg}-#{node['mysql']['community']['version']}-1.el6.x86_64.rpm"

    remote_file "/usr/local/src/#{package_name}" do
      owner "root"
      group "root"
      mode 00644
      source "#{node['mysql']['community']['url']}#{package_name}"
    end

    package package_name do
      action :install
      provider Chef::Provider::Package::Rpm
      source "/usr/local/src/#{package_name}"
    end
  end
end

template "/etc/my.cnf" do
  owner "root"
  group "root"
  mode 00644
  source "my_community_server.cnf.erb"
  notifies :restart, 'service[mysql]'
end

template "/etc/logrotate.d/mysql" do
  owner "root"
  group "root"
  mode 00644
  source "logrotate_mysqld_community.erb"
end

service "mysql" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

include_recipe "mysql::secure_installation_#{node['mysql']['version']['major']}"
