Factory.define :artwork do |f|
  f.sequence(:title) {|i| "Test Artwork #{i}"}
  f.sequence(:year) { rand(55)+1946 }
end

