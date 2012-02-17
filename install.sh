#!/bin/bash
 
# This runs as root on the server
 
chef_binary=/var/lib/gems/1.9.1/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    aptitude update &&
      apt-get -o Dpkg::Options::="--force-confnew" \
      --force-yes -fuy dist-upgrade &&
    # Install Ruby and Chef
    apt-get install -y build-essential libopenssl-ruby &&
    aptitude install -y ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 make &&
      ln -s /usr/bin/ruby1.9.1 /usr/bin/ruby &&
      ln -s /usr/bin/irb1.9.1 /usr/bin/irb &&
      gem install --no-rdoc --no-ri chef --version 0.10.0

fi &&
 
"$chef_binary" -c solo.rb -j solo.json
