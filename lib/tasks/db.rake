namespace :db do
  namespace :test do
    task :prepare do
      # Placeholder for Cucumber
    end
  end
  
  desc "Stub out for MongoDB/Mongoid to use with parallel_tests gem"
  task :abort_if_pending_migrations do
  end
end
