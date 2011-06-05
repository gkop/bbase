Factory.define :user do |f|
  f.sequence(:name) {|i| "Test User #{i}"}
  f.sequence(:email) {|i| "testuser_#{i}@test.golahny.org"}
  f.password 'Blueberry23'
  f.password_confirmation 'Blueberry23'
end

Factory.define :admin, :parent => :user do |f|
  f.admin true
end

def login_admin
  admin = Factory.create(:admin)
  sign_in admin
  admin
end

def login_user
  user = Factory.create(:user)
  sign_in user
  user
end

