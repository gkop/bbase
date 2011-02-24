require 'spec_helper'

describe ImageUploader do

  context "process an image after its been uploaded" do
    it "resizes an existing uploaded image" do
      artwork = Factory.create(:artwork_with_an_image)
      artwork.image.resize_later
    end
  end
end
