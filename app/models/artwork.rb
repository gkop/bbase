class Artwork
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :year, :type => Integer

  mount_uploader :image, ImageUploader

  references_one :location_created, :class_name => "Site"
#  references_one :location_stored, :class_name => "Site"
#  references_one :collection, :class_name => "Site"
#  references_many :exhibitions, :class_name => "Site"

   validates_numericality_of :year, :greater_than => 1937, :less_than => 2001, :allow_blank => true
end
