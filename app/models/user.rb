class User
  include Mongoid::Document
  field :name, :type => String
  field :email, :type => String
  field :password_hash, :type => String
  field :password_reset, :type => String
end
