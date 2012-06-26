class Artwork
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :title, :type => String
  field :note, :type => String
  field :year, :type => Integer
  field :display_year, :type => String
  field :height, :type => Integer
  field :width, :type => Integer
  field :grandpa_index, :type => Integer
  key :title

  # easiest way to store the dimensions of the different versions :/
  ["", "_fullscreen", "_slideshow", "_square", "_collage", "_bigtoe", "_thumb", "_tiny"].each do |v|
    ["_width", "_height"].each do |f|
      field "image#{v}#{f}".to_sym, :type => Integer
    end
  end

  mount_uploader :image, ImageUploader, mount_on: :image_filename

  references_one :location_created, :class_name => "Site"
#  references_one :location_stored, :class_name => "Site"
#  references_one :collection, :class_name => "Site"
#  references_many :galleries, :class_name => "Site"
   
  references_and_referenced_in_many :galleries, :class_name => "Gallery", :inverse_of => :artworks

  before_save :sanitize_note
  validates_uniqueness_of :title
  validates_presence_of :title
  validates_numericality_of :year, :greater_than => 1937, :less_than => 2006, :allow_blank => true
  validate :check_for_collision
 
  # validate uniqueness of key 
  def check_for_collision
    canonical_id = title.identify
    artworks = Artwork.all(:conditions => {:id => canonical_id})
    if artworks.count > 1 || (artworks.count == 1 && artworks.first != self)
      errors.add(:base, "Title too similar to that of an existing artwork")
    end
  end   

  def sanitize_note
    self.note = Sanitize.clean(note, Sanitize::Config::RELAXED)
  end

  def to_json
    binding.pry
  end
end
