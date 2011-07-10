require 'bundler/capistrano'

set :application, "bbase"
set :repository,  "git@github.com:gkop/bbase.git"

set :scm, :git

role :web, "golahny.org"
role :app, "golahny.org"
role :db,  "golahny.org", :primary => true

ssh_options[:forward_agent] = true

set :branch, "master"

set :deploy_to, "/opt/#{application}"

# deploy task for Passenger
namespace :deploy do

  desc "Tell Passenger to restart the app" 
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared config on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/sensitive.yml #{release_path}/config/sensitive.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
