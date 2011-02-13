Given /^I have an exhibition named "([^"]*)"$/ do |name|
  exhibition = Factory.build(:exhibition, :name => name)
  @user.exhibitions << exhibition
  exhibition.save!
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
  @exhibition = @user.exhibitions.find(:first, :conditions => {:name => exhibition })
  @exhibition.artworks << @artwork
  @artwork.save!
end


