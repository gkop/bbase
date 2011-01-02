class Site
  include Mongoid::Document
  field :name, :type => String
  field :address, :type => String

  referenced_in :city
  referenced_in :artwork

  validates_presence_of :name
end
