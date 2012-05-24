
apache_site "default" do
  enable false
end

apache_module 'rewrite' do
  enable true
end

directory "/var/www/angrywords" do
  owner "aw"
  group "aw"
  mode "0755"
  action :create
end

cookbook_file "#{node[:apache][:dir]}/sites-available/angrywords.conf" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

apache_site "angrywords.conf" do
  enable true
end

directory "/var/www/angrywords-staging" do
  owner "aw"
  group "aw"
  mode "0755"
  action :create
end

dbi = data_bag_item('aw', 'staging')
template "/var/www/angrywords-staging/passwords" do
  source "passwords.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  # variables :password => 'hithere'
  variables :password => dbi['password']
end

cookbook_file "#{node[:apache][:dir]}/sites-available/angrywords-staging.conf" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

apache_site "angrywords-staging.conf" do
  enable true
end

service "apache2" do
  action :restart
end

