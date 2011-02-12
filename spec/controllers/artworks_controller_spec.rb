require 'spec_helper'

describe ArtworksController do
  include Devise::TestHelpers

  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end

  context "GET index" do
    it "displays a list of all artworks" do
      5.times do
        Factory.create(:artwork)
      end  
      get :index, :format => :html
      response.should be_success
      response.should render_template :index
      artworks = assigns(:artworks)
      artworks.size.should == 5
    end
  end

  context "GET show" do
    it "shows a specific artwork" do
      new_artwork = Factory.create(:artwork)
      get :show, :id => new_artwork.id, :format => :html
      response.should be_success
      response.should render_template :show
      artwork = assigns(:artwork)
      artwork.should == new_artwork 
    end
  end

  context "GET new" do
    it "displays the new artwork form" do
      get :new, :format => :html
      response.should be_success
      response.should render_template :new
      artwork = assigns(:artwork)
      artwork.should_not == nil
    end
  end
  
  context "GET edit" do
    it "displays the edit artwork form" do
      new_artwork = Factory.create(:artwork)
      get :edit, :id => new_artwork.id, :format => :html
      response.should be_success
      response.should render_template :edit
      artwork = assigns(:artwork)
      artwork.should == new_artwork
    end
  end

  context "PUT update" do
    it "updates an artwork" do
      new_artwork = Factory.create(:artwork)
      put :update, :id => new_artwork.id, :format => :html, :artwork => {:title => "test update artwork"}
      response.should be_redirect
      flash[:notice].should == "Artwork was successfully updated."
      artwork = assigns(:artwork)
      artwork.id.should == artwork.id
      artwork.title.should == "test update artwork"
      response.should redirect_to artwork
    end
  end

  context "DELETE destroy" do
    it "destroys an artwork" do
      new_artwork = Factory.create(:artwork)
      delete :destroy, :id => new_artwork.id, :format => :html
      response.should be_redirect
      response.should redirect_to artworks_path
      Artwork.all(:conditions => {:id => new_artwork.id}).count.should == 0
    end
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
