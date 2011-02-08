require 'spec_helper'

describe ArtworksController do
  include Devise::TestHelpers

  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end

  context "POST create" do
    it "creates a new artwork" do
      artwork_title = "test artwork"
      artwork_year = "1950"
      artwork = mock_model(Artwork)
      Artwork.should_receive(:new).exactly(2).times.and_return(artwork)
      artwork.should_receive(:attributes=)

      post :create, :artwork => {:title => artwork_title, :year => artwork_year}

      response.should be_redirect
      response.should redirect_to artwork
      flash[:notice].should == "Artwork was successfully created."
    end
  end
end
