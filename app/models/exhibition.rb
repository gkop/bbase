class Exhibition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :note, :type => String
  field :curated, :type => Boolean

  attr_protected :curated

  references_and_referenced_in_many :artworks, :class_name => "Artwork", :inverse_of => :exhibitions
  belongs_to :user
  before_save :sanitize_note
  validates_presence_of :name

  scope :non_empty, where(:artwork_ids.ne=> [])

  def assign_to_homepage
    Settings.set(:homepage_exhibition, self.id)
  end
 
  def is_on_homepage?
    if Settings.get(:homepage_exhibition) ==  self.id
      true
    else
      false
    end 
  end
 
  def to_json
    json_exhibition = {}
    json_exhibition[:name ]= self.name
    json_exhibition[:artworks] = []
    self.artworks.each do |artwork|
      json_artwork = {}
      json_artwork[:big_image_url] = artwork.image.slideshow.url
      json_artwork[:small_image_url] = artwork.image.bigtoe.url
      json_artwork[:id] = artwork.id
      json_artwork[:title] = artwork.title
      json_artwork[:year] = artwork.year
      json_exhibition[:artworks] << json_artwork
    end
    json_exhibition.to_json
  end

  def sanitize_note
    self.note = Sanitize.clean(note, Sanitize::Config::RELAXED)
  end

  def self.assigned_to_homepage
    if Settings.get(:homepage_exhibition)
      self.find(Settings.get(:homepage_exhibition))
    end
  end

  # returns num artworks at random
  def random_artworks(num)
    self.artworks.shuffle.slice(0, num)
  end
end
