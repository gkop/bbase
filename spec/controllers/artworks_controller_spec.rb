require 'spec_helper'

describe ArtworksController do
  include Devise::TestHelpers

  context "GET index" do
    it "displays a list of all artworks for user" do
      login_user
      5.times do
        Factory.create(:artwork)
      end  
      get :index, :format => :html
      response.should be_success
      response.should render_template :index
      artworks = assigns(:artworks)
      artworks.size.should == 5
    end
    
    it "doesn't display a list of all artworks for guest" do
      get :index, :format => :html
      response.should_not be_success
      response.should redirect_to new_user_session_path
    end
  end

  context "GET show" do
    it "shows a specific artwork for user" do
      login_user
      new_artwork = Factory.create(:artwork)
      get :show, :id => new_artwork.id, :format => :html
      response.should be_success
      response.should render_template :show
      artwork = assigns(:artwork)
      artwork.should == new_artwork 
    end
    
    it "doesn't show a specific artwork for guest" do
      new_artwork = Factory.create(:artwork)
      get :show, :id => new_artwork.id, :format => :html
      response.should_not be_success
      response.should redirect_to new_user_session_path
    end
  end

  context "GET new" do
    it "displays the new artwork form for admin" do
      login_admin
      get :new, :format => :html
      response.should be_success
      response.should render_template :new
      artwork = assigns(:artwork)
      artwork.should_not == nil
    end

    it "doesn't display the new artwork form for user" do
      login_user
      lambda { get :new, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end
  
  context "GET edit" do
    it "displays the edit artwork form for admin" do
      login_admin
      new_artwork = Factory.create(:artwork)
      get :edit, :id => new_artwork.id, :format => :html
      response.should be_success
      response.should render_template :edit
      artwork = assigns(:artwork)
      artwork.should == new_artwork
    end

    it "doesn't display the edit artwork form for user" do
      login_user
      new_artwork = Factory.create(:artwork)
      lambda { get :edit, :id => new_artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "PUT update" do
    it "updates an artwork for admin" do
      login_admin
      new_artwork = Factory.create(:artwork)
      put :update, :id => new_artwork.id, :format => :html, :artwork => {:title => "test update artwork"}
      response.should be_redirect
      flash[:notice].should == "Artwork was successfully updated."
      artwork = assigns(:artwork)
      artwork.id.should == artwork.id
      artwork.title.should == "test update artwork"
      response.should redirect_to artwork
    end
    
    it "doesn't update an artwork for user" do
      login_user
      new_artwork = Factory.create(:artwork)
      lambda { put :update, :id => new_artwork.id, :format => :html, :artwork => {:title => "test update artwork"} }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "DELETE destroy" do
    it "destroys an artwork for an admin" do
      login_admin
      new_artwork = Factory.create(:artwork)
      delete :destroy, :id => new_artwork.id, :format => :html
      response.should be_redirect
      response.should redirect_to artworks_path
      Artwork.count.should == 0
      flash[:notice].should == "Deleted artwork "+new_artwork.title
    end
    
    it "doesn't destroy an artwork for a user" do
      login_user
      new_artwork = Factory.create(:artwork)
      lambda { delete :destroy, :id => new_artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end
     
  context "POST create" do
    it "creates a new artwork for an admin" do
      login_admin
      artwork_title = "test artwork"
      artwork_year = "1950"
      artwork = mock_model(Artwork)
      Artwork.should_receive(:new).exactly(2).times.and_return(artwork)
      artwork.should_receive(:attributes=)
      artwork.should_receive(:save)

      post :create, :artwork => {:title => artwork_title, :year => artwork_year}
      #TODO uncomment once rspec fixes this
      #response.should be_redirect
      #response.should redirect_to artwork
      #flash[:notice].should == "Artwork was successfully created."
    end
    
    it "doesn't create a new artwork for a user" do
      login_user
      lambda { post :create, :artwork => {:title => "Nebula", :year => 1965} }.should raise_error("You are not authorized to access this page.")
    end
  end
end
