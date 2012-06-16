package 'imagemagick'
package 'libxml2'
package 'libxml2-dev'
package 'libyaml-0-2'
package 'libyaml-dev'
package 'libxslt1.1'
package 'libxslt-dev'
package 'postfix'
package 'mailutils'
package 'monit'
package 'moreutils'

apache_site "default" do
  enable false
end

apache_module 'rewrite' do
  enable true
end

apache_module 'ssl' do
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

cookbook_file "#{node[:apache][:dir]}/ssl/alienwords.crt" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

cookbook_file "#{node[:apache][:dir]}/ssl/PositiveSSLCA2.crt" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

cookbook_file "#{node[:apache][:dir]}/ssl/AddTrustExternalCARoot.crt" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

cookbook_file "#{node[:apache][:dir]}/ssl/alienwords-chain.crt" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

dbi = data_bag_item('aw', 'ssl')
template "#{node[:apache][:dir]}/ssl/alienwords.key" do
  source "alienwords.key.erb"
  owner "root"
  group "root"
  mode "0600"
  action :create
  variables :key => dbi['key']
end

dbi = data_bag_item('aw', 'staging')
template "/var/www/alienwords-staging/passwords" do
  source "passwords.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  variables :password => dbi['password'],
            :stripe_password => dbi['stripe_password']
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

package 'monit'
cookbook_file "/etc/monit/monitrc" do
  owner "root"
  group "root"
  mode "0600"
  action :create
end

cron 'db_backups' do
  minute 22
  hour 2
  user 'aw'
  command "cd /var/www/alienwords/current && /usr/bin/chronic /usr/bin/env RAILS_ENV=production /usr/local/bin/rvm -S rake db:backup"
  mailto 'pj@illuminatedcomputing.com'
end
