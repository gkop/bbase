source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'mongoid'
gem 'bson_ext'

gem 'haml'
gem 'hpricot'

gem 'ruby_parser'

# authentication
gem 'devise'

# authorization
gem 'cancan'

# roles
# gem 'cream', :git => 'https://github.com/kristianmandrup/cream.git'

# user uploads
gem 'carrierwave'

# edit images
gem 'mini_magick', :git => 'git://github.com/probablycorey/mini_magick.git'

# states dropdown
gem 'us_states_select'

# tagging system
gem 'mongoid_taggable'

# dynamic nested forms
gem 'formtastic', '~> 1.1.0'
gem "formtastic_cocoon"

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
end
