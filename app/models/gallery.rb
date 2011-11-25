class Gallery
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :note, :type => String
  field :curated, :type => Boolean

  attr_protected :curated

  references_and_referenced_in_many :artworks, :class_name => "Artwork", :inverse_of => :galleries
  belongs_to :user
  before_save :sanitize_note
  validates_presence_of :name

  scope :non_empty, where(:artwork_ids.ne=> [])

  def assign_to_homepage
    Settings.set(:homepage_gallery, self.id)
  end
 
  def is_on_homepage?
    if Settings.get(:homepage_gallery) ==  self.id
      true
    else
      false
    end 
  end
 
  def to_json
    json_gallery = {}
    json_gallery[:name ]= self.name
    json_gallery[:artworks] = []
    self.artworks.each do |artwork|
      json_artwork = {}
      json_artwork[:big_image_url] = artwork.image.slideshow.url
      json_artwork[:small_image_url] = artwork.image.bigtoe.url
      json_artwork[:id] = artwork.id
      json_artwork[:title] = artwork.title
      json_artwork[:year] = artwork.year
      json_gallery[:artworks] << json_artwork
    end
    json_gallery.to_json
  end

  def sanitize_note
    self.note = Sanitize.clean(note, Sanitize::Config::RELAXED)
  end

  def self.assigned_to_homepage
    if Settings.get(:homepage_gallery)
      self.find(Settings.get(:homepage_gallery))
    end
  end

  # returns an artwork at random
  def random_artwork
    self.random_artworks(1).first
  end

  # returns num artworks at random
  def random_artworks(num)
    self.artworks.shuffle.slice(0, num)
  end
end
