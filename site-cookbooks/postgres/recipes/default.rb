include_recipe "postgres::server"

cookbook_file "/root/.psqlrc" do
  source "psqlrc"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

