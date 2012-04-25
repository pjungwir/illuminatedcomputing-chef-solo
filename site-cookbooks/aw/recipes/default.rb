
apache_site "default" do
  enable false
end

directory "/var/www/angrywords" do
  owner "aw"
  group "aw"
  mode "0755"
  action :create
end

apache_module 'rewrite' do
  enable true
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

service "apache2" do
  action :restart
end

