Factory.define :user do |f|
  f.sequence(:name) {|i| "Test Artwork #{i}"}
  f.sequence(:email) {|i| "testuser_#{i}@test.golahny.org"}
  f.password 'Blueberry23'
  f.password_confirmation 'Blueberry23'
end

Factory.define :admin, :parent => :user do |f|
  f.admin true
end
