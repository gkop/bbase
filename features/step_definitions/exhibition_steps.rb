Given /^I have a gallery named "([^"]*)"$/ do |name|
  @gallery = Factory.build(:gallery, :name => name)
  @current_user.galleries << @gallery
  @gallery.save!
end

Given /^I have a gallery named "([^"]*)" with an artwork in it$/ do |name|
  step %{I have a gallery named "#{name}"}
  @gallery.artworks << Factory(:artwork)
  @gallery.save!
end

Given /^the gallery has the artworks "([^"]*)"$/ do |artworks|
  @gallery ? gallery = @gallery : gallery = @homepage_gallery
  artworks.split(',').each do |title|
    artwork = Factory.create(:artwork, :title => title.strip)
    gallery.artworks << artwork
    artwork.save!
  end
end

Given /^I have added the artwork to "([^"]*)"$/ do |gallery|
  @gallery = @current_user.galleries.find(:first, :conditions => {:name => gallery })
  @gallery.artworks << @artwork
  @artwork.save!
end

Then /^I should see a byline by my gallery$/ do
  step %{I should see "by #{@gallery.user.name}" within ".caption"}
end

Then /^I should not see a byline by the gallery$/ do
  step %{I should not see "by #{@gallery.user.name}"}
end

