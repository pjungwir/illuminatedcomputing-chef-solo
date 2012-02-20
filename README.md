# Chef scripts for IlluminatedComputing.com

This respository is used for a [chef-solo tutorial](http://illuminatedcomputing.com/posts/2012/02/simple-chef-solo-tutorial/) at [illuminatedcomputing.com](http://illuminatedcomputing.com/).

First, add a symlink named `cookbooks` to a checkout of my [standard cookbook collection](https://github.com/pjungwir/cookbooks).

Second, copy `data-bags/users/ic.json.example` to `data-bags/users/ic.json` and insert your public ssh key (if any).

Finally, run ./deploy.sh to run chef-solo on a fresh VPS.


