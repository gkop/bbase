FactoryGirl.define do
  factory :gallery do
    sequence(:name) {|i| "Test Gallery #{i}"}
    after_create do |gallery|
      #user.galleries << gallery
      #gallery.save!
    end
    user { FactoryGirl.create(:user) }
  end

  factory :homepage_gallery, :parent => :gallery do
    after_create do |gallery|
      gallery.assign_to_homepage
    end
  end
end
