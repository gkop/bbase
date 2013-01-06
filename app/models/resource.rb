class Resource
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  include Mongoid::Sanitizable

  field :title, :type => String
  field :note, :type => String
  field :asset_filename, :type => String
  key :title

  validates_uniqueness_of :title
  validates_presence_of :title
  validate :check_for_collision
  sanitizes :note

  def primary_tag
    (tags_array & ['writing', 'response']).first
  end

  def type
    primary_tag.capitalize
  end

  private
  # validate uniqueness of key
  def check_for_collision
    canonical_id = title.identify
    resources = Resource.all(:conditions => {:id => canonical_id})
    if resources.count > 1 || (resources.count == 1 && resources.first != self)
      errors.add(:base, "Title too similar to that of an existing resource")
    end
  end
end
