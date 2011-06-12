class Artwork
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :title, :type => String
  field :year, :type => Integer
  key :title

  mount_uploader :image, ImageUploader

  references_one :location_created, :class_name => "Site"
#  references_one :location_stored, :class_name => "Site"
#  references_one :collection, :class_name => "Site"
#  references_many :exhibitions, :class_name => "Site"
   
  references_and_referenced_in_many :exhibitions, :class_name => "Exhibition", :inverse_of => :artworks

  validates_uniqueness_of :title
  validates_presence_of :title
  validates_numericality_of :year, :greater_than => 1937, :less_than => 2001, :allow_blank => true
  validate :check_for_collision, :on => [:create, :update]
 
  # validate uniqueness of key 
  def check_for_collision
    canonical_id = title.identify
    artworks = Artwork.all(:conditions => {:id => canonical_id})
    if artworks.count > 0
      errors.add(:base, "Title too similar to that of an existing artwork")
    end
  end   
end
