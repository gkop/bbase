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

Given /^a couple curated, non\-empty galleries exist$/ do
  @curated_galleries = []
  2.times do
    new_gallery = Factory(:gallery, :curated => true)
    new_gallery.artworks << Factory(:artwork)
    @curated_galleries << new_gallery
  end
end

Given /^a couple uncurated, non\-empty galleries exist$/ do
  @uncurated_galleries = []
  2.times do
    new_gallery = Factory(:gallery)
    new_gallery.artworks << Factory(:artwork)
    @uncurated_galleries << new_gallery
  end
end

Then /^the curated galleries should come before the uncurated ones$/ do
  text = page.text
  curated_indices = @curated_galleries.map {|g| text.index(g.name) }
  uncurated_indices = @uncurated_galleries.map {|g| text.index(g.name) }
  curated_indices.each do |curated_index|
    uncurated_indices.each do |uncurated_index|
      curated_index.should < uncurated_index          
    end
  end
end
