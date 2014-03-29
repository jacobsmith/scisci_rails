set :application, "scisci"
set :repository,  "git@github.com:jacobsmith/scisci_rails.git"
set :deploy_to,   "/home/deployer/www"
set :scm, "git"
set :branch, "master"
set :user, "deployer"
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 1492 }
set :keep_releases, 5
set :use_sudo, "false"

default_run_options[:pty] = true


server "107.170.25.198", :app, :web, :db, :primary => true
# tutorial from http://robmclarty.com/blog/how-to-deploy-a-rails-4-app-with-git-and-capistrano



require "rvm/capistrano"

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs

before 'deploy:setup', 'rvm:install_rvm'  # install/update RVM
before 'deploy:setup', 'rvm:install_ruby'

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
after "deploy", "deploy:symlink_config_files"

namespace :deploy do
  desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end

  desc "install bundled gems"
  task :bundle_install do
    run "bundle install"
  end
end


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
