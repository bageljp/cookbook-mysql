#
# Cookbook Name:: mysql
# Recipe:: community_client
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
    mysql-community-client
    mysql-community-common
    mysql-community-devel
    mysql-community-libs
    mysql-community-libs-compat
  ).each do |pkg|
    package pkg do
      action :install
    end
  end
when 'rpm'
  # rpm
  %w(
    MySQL-client
    MySQL-devel
    MySQL-shared
    MySQL-shared-compat
  ).each do |pkg|
    package_name = "#{pkg}-#{node['mysql']['community']['version']}-1.#{node['mysql']['version']['platform']}.x86_64.rpm"

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

#template "/etc/my.cnf" do
#  owner "root"
#  group "root"
#  mode 00644
#  source "my_client.cnf.erb"
#end
