FactoryGirl.define do
  factory :artwork do
    sequence(:title) {|i| "Test Artwork #{i}"}
    year (Kernel.rand(55)+1946)
  end

  factory :artwork_with_an_image, :parent => :artwork do
    image File.open(File.join(Rails.root, "spec", "data", "ring_nebula_1987.jpg"))
  end

  factory :drawing, :parent => :artwork do
    tags 'drawing'
  end

  factory :painting, :parent => :artwork do
    tags 'painting'
  end

  factory :print, :parent => :artwork do
    tags 'print'
  end

  factory :sculpture, :parent => :artwork do
    tags 'sculpture'
  end
end
