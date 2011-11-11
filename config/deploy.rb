$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
require 'bundler/capistrano'

load 'deploy/assets'

set :application, "bbase"
set :repository,  "git@github.com:gkop/bbase.git"

set :scm, :git

role :web, "golahny.org"
role :app, "golahny.org"
role :db,  "golahny.org", :primary => true

ssh_options[:forward_agent] = true

set :branch, "master"

set :deploy_to, "/opt/#{application}"

set :rvm_ruby_string, 'ree@bbase'
set :rvm_bin_path, "/usr/local/rvm/bin"

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

  task :set_current_release, :roles => :app do
    set :current_release, latest_release
  end
end

before 'deploy:finalize_update', 'deploy:set_current_release'
before 'deploy:assets:precompile', 'deploy:symlink_shared'
