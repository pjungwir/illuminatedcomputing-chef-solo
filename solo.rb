root = File.absolute_path(File.dirname(__FILE__))

data_bag_path root + '/data_bags'
file_cache_path root
cookbook_path [root + '/cookbooks', root + '/site-cookbooks']
