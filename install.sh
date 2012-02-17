#!/bin/bash
 
# This runs as root on the server
 
chef_binary=/usr/local/rvm/gems/ruby-1.9.3-p0/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    apt-get update -o Acquire::http::No-Cache=True
    apt-get -o Dpkg::Options::="--force-confnew" \
      --force-yes -fuy dist-upgrade

    # Install RVM as root (System-wide install)
    apt-get install -y curl git-core bzip2 build-essential zlib1g-dev libssl-dev

    bash <(curl -L https://github.com/wayneeseguin/rvm/raw/1.3.0/contrib/install-system-wide) --version '1.3.0'
    (cat <<'EOP'
[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
EOP
    ) > /etc/profile.d/rvm.sh

    # Install Ruby using RVM
    [[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
    rvm install 1.9.3-p0
    rvm use 1.9.3-p0 --default

    # Install chef
    gem install --no-rdoc --no-ri chef
fi
 
# Run chef-solo on server
[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
"$chef_binary" -c solo.rb -j solo.json
