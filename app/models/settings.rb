class Settings
  include Mongoid::Document
  include Mongoid::Sanitizable

  field :homepage_gallery, :type => BSON::ObjectId
  field :biography_content, :type => String

  sanitizes :biography_content

  def self.singleton
    if Settings.all.length > 0
      Settings.all.first
    else
      Settings.create!
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
end
