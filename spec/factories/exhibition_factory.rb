FactoryGirl.define do
  factory :gallery do
    sequence(:name) {|i| "Test Gallery #{i}"}
    user { FactoryGirl.create(:user) }
  end

  factory :homepage_gallery, :parent => :gallery do
    after(:create) do |gallery|
      gallery.assign_to_homepage
    end
  end
end
