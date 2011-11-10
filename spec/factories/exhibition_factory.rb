Factory.define :exhibition do |f|
  f.sequence(:name) {|i| "Test Exhibition #{i}"}
  f.after_create do |exhibition|
    #user.exhibitions << exhibition
    #exhibition.save!
  end
  f.user { Factory(:user) }
end

Factory.define :homepage_exhibition, :parent => :exhibition do |f|
  f.after_create do |exhibition|
    exhibition.assign_to_homepage
  end
end
