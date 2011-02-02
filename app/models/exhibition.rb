class Exhibition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  references_many :artworks, :class_name => "Artwork", :stored_as => :array, :inverse_of => :exhibitions

end
