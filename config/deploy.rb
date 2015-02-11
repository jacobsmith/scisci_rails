require "bundler/capistrano"
require "rvm/capistrano"
require 'capistrano/ext/multistage'

# server "162.243.244.32", :web, :app, :db, primary: true
# stage specific code can go in deploy/#{deploy_target}
# this code takes care of unified deployements

set :stages, ["staging", "production"]
#set :default_stage, "staging"
set :default_stage, "production"

set :application, "scisci"
set :user, "deployer"
set :port, 1492 
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:jacobsmith/scisci_rails.git"
set :branch, "master"


default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "#{current_path}/config/unicorn_init.sh #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
#    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :setup_backup, roles: :app do
    # modeled after http://www.wekeroad.com/2011/11/01/how-to-backup-your-postgres-db-to-amazon-nightly/
    run "mkdir -p #{shared_path}/lib/tasks" 
    put File.read("lib/tasks/backup.rake"), "#{shared_path}/lib/tasks/backup.rake"
    run "ln -nfs #{shared_path}/lib/tasks/backup.rake #{current_path}/lib/tasks/backup.rake"
    puts "backup.rake should be in shared/lib/tasks/ and linked with the current deploy -- be sure you edit the crontab appropriately!!!"
  end
  after "deploy:setup", "deploy:setup_config"


  task :symlink_config, roles: :app do
     run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end

  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
