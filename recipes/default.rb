#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2013, bageljp
#
# All rights reserved - Do Not Redistribute
#

template "/etc/my.cnf" do
  owner "root"
  group "root"
  mode 00644
end
