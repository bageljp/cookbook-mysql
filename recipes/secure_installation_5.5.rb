#
# Cookbook Name:: mysql
# Recipe:: secure_installation_5.5
#
# Copyright 2013, bageljp
#
# All rights reserved - Do Not Redistribute
#

temp_password = `head -n 1 ~/.mysql_secret | awk '{print $NF}'`

bash "mysql_secure_installation" do
  user "root"
  group "root"
  code <<-EOC
    mysql -u root -p#{temp_password} << EOF
      -- set root password
      UPDATE mysql.user SET Password=PASSWORD("#{node['mysql']['root_password']}") WHERE User='root';
      -- remove anonymous users
      DELETE FROM mysql.user WHERE User='';
      -- Disallow root login remotely
      DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
      -- Remove test database and access to it
      DROP DATABASE IF EXISTS test;
      DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
      -- Reload privilege tables now
      FLUSH PRIVILEGES;
EOF
  EOC
  only_if "mysql -u root -p#{temp_password} -e \"select Db from mysql.db where Db = 'test';\" | grep -q test"
end
