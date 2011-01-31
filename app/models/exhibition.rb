class Exhibition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  references_many :artworks, :class_name => "Artwork", :inverse_of => :exhibitions, :stored_as => :array
  
  referenced_in :user

end
