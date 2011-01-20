class Site
  include Mongoid::Document
  include Mongoid::Taggable

  field :name, :type => String
  field :address, :type => String

  references_one :city
    
  referenced_in :city
  referenced_in :artwork

  validates_presence_of :name
end
