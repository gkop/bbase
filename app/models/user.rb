class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :admin, :type => Boolean
  field :name, :type => String
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  attr_protected :admin

  has_many :galleries

  after_create :create_favorites

  protected
  def create_favorites
    favorites = Gallery.create(:name => "Favorites")
    self.galleries << favorites
  end
end
