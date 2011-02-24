Factory.define :artwork do |f|
  f.sequence(:title) {|i| "Test Artwork #{i}"}
  f.sequence(:year) { rand(55)+1946 }
end

Factory.define :artwork_with_an_image, :parent => :artwork do |f|
  f.image File.open(File.join(Rails.root, "spec", "data", "ring_nebula_1987.jpg"))
end

