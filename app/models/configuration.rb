class Configuration
  include Mongoid::Document

  field :homepage_exhibition, :type => BSON::ObjectId
  field :biography_content, :type => String
 
  before_save :sanitize_biography_content

  def self.singleton
    if Configuration.all.length > 0 
      Configuration.all.first
    else
      Configuration.create!
    end
  end

  def self.set(key, value)
    config = self.singleton
    config[key.to_sym] = value
    config.save!
  end

  def self.get(key)
    config = self.singleton
    config[key.to_sym]
  end

  def sanitize_biography_content
    self.biography_content = Sanitize.clean(biography_content, Sanitize::Config::RELAXED)
  end

end
