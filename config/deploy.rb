set :application, "sciscinotes"
set :repository,  "https://github.com/jacobsmith/scisci_rails"

set :deploy_to, "/home/deploy/"
set :scm, :git
set :branch, "master"
set :user, "root"
set :rails_env, "production"
set :rake, "/usr/local/rvm/bin/rake"
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "sciscinotes.com"                          # Your HTTP server, Apache/etc
role :app, "sciscinotes.com"                          # This may be the same as your `Web` server
role :db,  "sciscinotes.com", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do

  task :use_system_ruby do
    run "rvm use system"
  end

  ##taken from robmclarty.com
  desc "Symlink shared config files"
  task :symlink_config_files do
        run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end
end
