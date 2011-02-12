Given /^I have an exhibition named "([^"]*)"$/ do |name|
  exhibition = Factory.build(:exhibition, :name => name)
  @user.exhibitions << exhibition
  exhibition.save!
end

Given /^the exhibition has the artworks "([^"]*)"$/ do |artworks|
  @exhibition ? exhibition = @exhibition : exhibition = @homepage_exhibition
  artworks.split(',').each do |title|
    artwork = Factory.build(:artwork, :title => title.strip)
    exhibition.artworks << artwork
    artwork.save!
  end
end

