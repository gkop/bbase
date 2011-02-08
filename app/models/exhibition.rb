class Exhibition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  references_many :artworks, :class_name => "Artwork", :stored_as => :array, :inverse_of => :exhibitions

  def assign_to_homepage
    Configuration.set(:homepage_exhibition, self.id)
  end
 
  def is_on_homepage?
    if Configuration.get(:homepage_exhibition) ==  self.id
      true
    else
      false
    end 
  end

  def self.assigned_to_homepage
    Configuration.get(:homepage_configuration)
  end

end
