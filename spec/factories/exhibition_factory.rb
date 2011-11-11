Factory.define :gallery do |f|
  f.sequence(:name) {|i| "Test Gallery #{i}"}
  f.after_create do |gallery|
    #user.galleries << gallery
    #gallery.save!
  end
  f.user { Factory(:user) }
end

Factory.define :homepage_gallery, :parent => :gallery do |f|
  f.after_create do |gallery|
    gallery.assign_to_homepage
  end
end
