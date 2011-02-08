Given /^I have an exhibition named "([^"]*)"$/ do |name|
  exhibition = Factory.build(:exhibition, :name => name)
  @user.exhibitions << exhibition
  exhibition.save!
end

