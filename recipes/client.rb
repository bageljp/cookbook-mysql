#
# Cookbook Name:: mysql
# Recipe:: client
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
).each do |pkg|
  package pkg
end

#template "/etc/my.cnf" do
#  owner "root"
#  group "root"
#  mode 00644
#  source "my_client.cnf.erb"
#end
