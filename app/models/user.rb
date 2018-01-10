class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :admin, :type => Boolean
  field :name, :type => String
  field :email, :type => String
  field :encrypted_password, :type => String
  field :sign_in_count, :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at, :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip, :type => String
  field :remember_created_at, :type => Time
  field :invitation_token, :type => String
  field :invitation_sent_at, :type => Time
  field :invitation_accepted_at, :type => Time
  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Time
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
