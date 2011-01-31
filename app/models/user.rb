class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :name, :type => String
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  references_many :exhibitions, :class_name => "Exhibition", :foreign_key => "owner_id"

  after_create :create_favorites

  protected
  def create_favorites
    favorites = Exhibition.create(:name => "Favorites")
    self.exhibitions << favorites
  end
end
