source 'http://rubygems.org'

gem 'rails'

gem 'mongoid'
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
gem 'carrierwave', '0.5.4'

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
gem 'maruku'

# sanitize markdown
gem 'sanitize'
 
# deployment
gem 'capistrano'

# js runtime
gem 'therubyracer'

group :development do
  gem 'unicorn'
end

group :test, :development do
  gem 'capybara'
  gem 'cucumber-rails'
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
  gem 'sass-rails', " ~> 3.1.0"  
  gem 'coffee-rails', " ~> 3.1.0"  
  gem 'uglifier'  
end  
  
gem 'jquery-rails'  
