require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_resource/railtie'
require "rails/test_unit/railtie"

if defined?(Bundler)  
  # precompile assets before deploying to production,   
  Bundler.require *Rails.groups(:assets => %w(development test))  
end  

module Bbase
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w()

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
    config.generators do |g|
      g.orm             :mongoid 
      g.template_engine :haml
    end

    # Enable the asset pipeline  
    config.assets.enabled = true  
  
    # Version of your assets, change this if you want to expire all your assets  
    config.assets.version = '1.0'  
    config.assets.prefix = "/assets"
    config.action_dispatch.x_sendfile_header = "X-Accel-Redirect"  

  end
end

# load sensitive params from yaml file not in repo
yml_file = Rails.root.join('config', 'sensitive.yml')
begin
  SENSITIVE_CONFIG = YAML::load(File.open(yml_file))[Rails.env]
rescue Exception => ex
  Rails.logger.error "Error parsing sensitive parameters from yaml file #{yml_file}: #{ex.inspect}"
end
