class Gallery
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sanitizable
  include ArtworksHelper

  field :name, :type => String
  field :note, :type => String
  field :curated, :type => Boolean, :default => false

  attr_protected :curated

  references_and_referenced_in_many :artworks, :class_name => "Artwork", :inverse_of => :galleries
  belongs_to :user
  validates_presence_of :name
  sanitizes :note

  scope :non_empty, where(:artwork_ids.ne=> [])
  scope :curated, where(:curated => true)
  scope :uncurated, where(:curated => false)

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
