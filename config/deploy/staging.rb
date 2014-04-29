server "107.170.105.126", :app, :web, :db, :primary => true
set :deploy_to, "/home/#{user}/apps/#{application}"

before_deploy :turn_on_server

after_deploy :set_shutdown_timer
