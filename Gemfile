source 'http://rubygems.org'

gem 'rails', '~> 3.2.6'

gem 'mongoid', '~> 2.1'
gem 'bson_ext'

gem 'haml'
gem 'hpricot'

# authentication
gem 'devise'

# invitations
gem 'devise_invitable'

# authorization
gem 'cancan'

# roles
# gem 'cream', :git => 'https://github.com/kristianmandrup/cream.git'

# user uploads
gem 'carrierwave'
gem "carrierwave-mongoid", :require => 'carrierwave/mongoid', :git => 'https://github.com/jnicklas/carrierwave-mongoid'

# edit images
gem 'mini_magick', :git => 'git://github.com/probablycorey/mini_magick.git'

# tagging system
gem 'mongoid_taggable'

# dynamic nested forms
gem 'formtastic'
gem "cocoon"

# send emails via postmark
gem 'postmark-rails'

# use info from git inside the app
gem 'grit'

# render markdown
gem "redcarpet", "~> 1.17.2"

# sanitize markdown
gem 'sanitize'
 
# deployment
gem 'capistrano'
gem 'rvm-capistrano'

# js runtime
gem 'therubyracer'

group :development do
  gem 'unicorn'
end

group :test, :development do
  gem 'capybara'
  gem 'cucumber-rails', :require => false 
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'mongoid-rspec', :require => false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'capybara-webkit'
 
  # parallelize tests across cpu cores
  gem 'parallel_tests'

  # fancy debugger
  gem "pry", "~> 0.9.7"
  gem "pry-nav", "~> 0.0.4"
end

# Gems used only for assets and not required  
# in production environments by default.  
group :assets do  
  gem 'sass-rails'  
  gem 'coffee-rails'
  gem 'uglifier'  
end  
  
gem 'jquery-rails'  
