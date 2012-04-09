FactoryGirl.define do
  factory :user do
    sequence(:name) {|i| "Test User #{i}"}
    sequence(:email) {|i| "testuser_#{i}@test.golahny.org"}
    password 'Blueberry23'
    password_confirmation 'Blueberry23'
  end

  factory :admin, :parent => :user do
    admin true
  end
end

def login_admin
  admin = FactoryGirl.create(:admin)
  sign_in admin
  admin
end

def login_user
  user = FactoryGirl.create(:user)
  sign_in user
  user
end

