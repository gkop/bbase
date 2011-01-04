require 'spec_helper'

describe Artwork do
  it "increments the artwork count with a new artwork" do
    num_artworks = Artwork.count
    Factory.create(:artwork)
    Artwork.count.should == num_artworks + 1
  end
end
