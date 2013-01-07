class Resource
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  include Mongoid::Sanitizable
  include Mongoid::UniqueCompositeKey

  field :title, :type => String
  field :note, :type => String
  field :asset_filename, :type => String
  field :sort_order, :type => Integer, :default => -1
  key :title
  validates_unique_key

  validates_uniqueness_of :title
  validates_presence_of :title
  validates_numericality_of :sort_order
  sanitizes :note

  def primary_tag
    (tags_array & ['writing', 'response']).first
  end

  def type
    primary_tag.capitalize
  end
end
