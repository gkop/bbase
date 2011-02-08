class Configuration
  include Mongoid::Document

  field :homepage_exhibition, :type => BSON::ObjectId

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

end
