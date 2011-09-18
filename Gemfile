source 'http://rubygems.org'

gem 'rails', "3.1.0"

gem 'mongoid'
gem 'bson_ext'

gem 'haml'
gem 'hpricot'

gem 'ruby_parser'

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

# states dropdown
gem 'us_states_select'

# tagging system
gem 'mongoid_taggable'

# dynamic nested forms
gem 'formtastic'
gem "cocoon"

# send emails via postmark
gem 'postmark-rails'

# ruby 1.8.7 asked for this
gem 'SystemTimer'

# use info from git inside the app
gem 'grit'

# render markdown
gem 'rdiscount'

# sanitize markdown
gem 'sanitize'
 
# deployment
gem 'capistrano'

# fun
gem 'pry', :group => :development

group :development do
  gem 'unicorn'
  gem 'ruby-debug'
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
end
