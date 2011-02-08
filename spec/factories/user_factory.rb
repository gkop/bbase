Factory.define :user do |f|
  f.sequence(:name) {|i| "Test Artwork #{i}"}
  f.sequence(:email) {|i| "testuser_#{i}@test.golahny.org"}
end
