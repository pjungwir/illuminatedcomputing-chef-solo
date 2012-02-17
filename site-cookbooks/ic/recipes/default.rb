
apache_site "default" do
  enable false
end

directory "/var/www/ic" do
  owner "ic"
  group "ic"
  mode "0755"
  action :create
end

apache_module 'rewrite' do
  enable true
end

cookbook_file "#{node[:apache][:dir]}/sites-available/ic.conf" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

apache_site "ic.conf" do
  enable true
end

