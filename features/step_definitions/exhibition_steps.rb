Given /^I have a gallery named "([^"]*)"$/ do |name|
  @gallery = Factory.build(:exhibition, :name => name)
  @current_user.exhibitions << @gallery
  @gallery.save!
end

Given /^I have a gallery named "([^"]*)" with an artwork in it$/ do |name|
  When %Q{I have a gallery named "#{name}"}
  @gallery.artworks << Factory(:artwork)
  @gallery.save!
end

Given /^the exhibition has the artworks "([^"]*)"$/ do |artworks|
  @exhibition ? exhibition = @exhibition : exhibition = @homepage_exhibition
  artworks.split(',').each do |title|
    artwork = Factory.create(:artwork, :title => title.strip)
    exhibition.artworks << artwork
    artwork.save!
  end
end

Given /^I have added the artwork to "([^"]*)"$/ do |exhibition|
  @exhibition = @current_user.exhibitions.find(:first, :conditions => {:name => exhibition })
  @exhibition.artworks << @artwork
  @artwork.save!
end
