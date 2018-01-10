source 'http://rubygems.org'

ruby '2.3.1'

gem 'rails', '3.2.22.5'

gem "mongo", "~> 1.7.0"
gem 'mongoid', "~> 2.5.1"
gem 'mongoid_rails_migrations'
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

# render markdown
gem "redcarpet", "~> 1.17.2"

# sanitize markdown
gem 'sanitize'

# deployment
gem 'capistrano'
gem 'rvm-capistrano', require: false

# more concise logging in development
gem 'quiet_assets'

group :development do
  gem 'unicorn'
end

group :test, :development do
  gem 'capybara', "2.4.4"
  gem 'cucumber-rails', :require => false
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'mongoid-rspec', :require => false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'capybara-webkit', "1.6.0"

  # parallelize tests across cpu cores
  gem 'parallel_tests'

  # fancy debugger
  gem "pry", "~> 0.9.7"
  gem "pry-nav", "~> 0.0.4"
end

group :test do
  gem 'test-unit'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'
