server "107.170.105.126", :app, :web, :db, :primary => true
set :deploy_to, "/home/#{user}/apps/#{application}"
