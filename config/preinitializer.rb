yml_file = Rails.root.join('config', 'sensitive.yml')
begin
  SENSITIVE_CONFIG = YAML::load(File.open(yml_file))[Rails.env]
rescue Exception => ex
  Rails.logger.error "Error parsing sensitive parameters from yaml file #{yml_file}: #{ex.inspect}"
end
