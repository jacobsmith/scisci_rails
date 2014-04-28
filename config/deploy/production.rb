server "162.243.244.32", :app, :web, :db, :primary => true
set :deploy_to, "/home/#{user}/apps/#{application}"
