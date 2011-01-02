class Artwork
  include Mongoid::Document

  field :title, :type => String

  references_one :location_created, :class_name => "Site"
  references_one :location_stored, :class_name => "Site"
  references_one :collection, :class_name => "Site"
  references_many :exhibitions, :class_name => "Site"
end
