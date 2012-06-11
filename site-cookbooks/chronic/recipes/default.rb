# Chronic is not part of the Ubuntu moreutils package,
# so add it manually:

package 'libipc-run-perl'

cookbook_file "/usr/bin/chronic" do
  source "chronic"
  owner "root"
  group "root"
  mode "0755"
  action :create
end
