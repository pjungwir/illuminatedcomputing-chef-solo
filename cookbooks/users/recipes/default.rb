#
# Cookbook Name:: users
# Recipe:: default
#

(node[:users] || {}).each do |key, u|

  group u['id'] do
    gid u['gid']
    append true
  end

  user u['id'] do
    uid u['uid']
    gid u['gid']
    # password u['password']
    shell u['shell']
    comment u['comment']
    home "/home/#{u['id']}"
    supports :manage_home => true
    # notifies :create, "ruby_block[reset group list]", :immediately
  end

  if u['ssh_keys']
    directory "/home/#{u['id']}/.ssh" do
      owner u['id']
      group u['id']
      mode '0700'
    end
    file "/home/#{u['id']}/.ssh/authorized_keys" do
      owner u['id']
      group u['id']
      mode '0600'
      content u['ssh_keys'].join("\n")
    end
  end

end

