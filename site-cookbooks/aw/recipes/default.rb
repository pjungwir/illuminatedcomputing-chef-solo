package 'imagemagick'
package 'libxml2'
package 'libxml2-dev'
package 'libyaml-0-2'
package 'libyaml-dev'
package 'libxslt1.1'
package 'libxslt-dev'

apache_site "default" do
  enable false
end

apache_module 'rewrite' do
  enable true
end

directory "/var/www/alienwords" do
  owner "aw"
  group "aw"
  mode "0755"
  action :create
end

cookbook_file "#{node[:apache][:dir]}/sites-available/alienwords.conf" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

apache_site "alienwords.conf" do
  enable true
end

directory "/var/www/alienwords-staging" do
  owner "aw"
  group "aw"
  mode "0755"
  action :create
end

dbi = data_bag_item('aw', 'staging')
template "/var/www/alienwords-staging/passwords" do
  source "passwords.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  # variables :password => 'hithere'
  variables :password => dbi['password']
end

cookbook_file "#{node[:apache][:dir]}/sites-available/alienwords-staging.conf" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

apache_site "alienwords-staging.conf" do
  enable true
end

service "apache2" do
  action :restart
end

