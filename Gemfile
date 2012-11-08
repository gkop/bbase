source 'http://rubygems.org'

gem 'rails', '3.2.8'

gem 'mongoid'
gem 'bson_ext'

gem 'haml'

# authentication
gem 'devise'

# invitations
gem 'devise_invitable'

# authorization
gem 'cancan'

# user uploads
gem 'carrierwave'
gem "carrierwave-mongoid", :require => 'carrierwave/mongoid'

# edit images
gem 'mini_magick'

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
