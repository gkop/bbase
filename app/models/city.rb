class City
  include Mongoid::Document
  field :name, :type => String
  field :state, :type => String
  field :country, :type => String
  
  references_many :sites

  validates_presence_of :name

end
