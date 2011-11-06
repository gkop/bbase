require 'spec_helper'

describe ArtworksController do
  include Devise::TestHelpers
 
  let(:new_artwork) {Factory(:artwork)}

  context "GET index" do
    it "displays a list of all artworks for user" do
      login_user
      2.times {Factory(:artwork)}
      get :index
      response.should render_template :index
      assigns(:artworks).size.should == 2
    end
    
    it "displays a list of all artworks for guest" do
      get :index
      response.should render_template :index
    end
  end

  context "GET show" do
    it "shows a specific artwork for user" do
      login_user
      get :show, :id => new_artwork.id
      response.should render_template :show
      assigns(:artwork).should == new_artwork 
    end
    
    it "shows specific artwork for guest" do
      get :show, :id => new_artwork.id
      response.should render_template :show
      assigns(:artwork).should == new_artwork 
    end
  end

  context "GET new" do
    it "displays the new artwork form for admin" do
      login_admin
      get :new
      response.should render_template :new
      assigns(:artwork).should_not be_blank
    end

    it "doesn't display the new artwork form for user" do
      login_user
      lambda {get :new}.should raise_error("You are not authorized to access this page.")
    end
  end
  
  context "GET edit" do
    it "displays the edit artwork form for admin" do
      login_admin
      get :edit, :id => new_artwork.id
      response.should render_template :edit
      assigns(:artwork).should == new_artwork
    end

    it "doesn't display the edit artwork form for user" do
      login_user
      lambda { get :edit, :id => new_artwork.id }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "PUT update" do
    it "updates an artwork for admin" do
      login_admin
      put :update, :id => new_artwork.id, :artwork => {:title => "test update artwork"}
      artwork = assigns(:artwork)
      artwork.id.should == artwork.id
      artwork.title.should == "test update artwork"
      response.should redirect_to artwork
      flash[:notice].should == "Artwork was successfully updated."
    end
    
    it "doesn't update an artwork for user" do
      login_user
      lambda { put :update, :id => new_artwork.id, :artwork => {:title => "test update artwork"} }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "DELETE destroy" do
    it "destroys an artwork for an admin" do
      login_admin
      delete :destroy, :id => new_artwork.id
      response.should redirect_to artworks_path
      Artwork.count.should == 0
      flash[:notice].should == "Deleted artwork "+new_artwork.title
    end
    
    it "doesn't destroy an artwork for a user" do
      login_user
      lambda { delete :destroy, :id => new_artwork.id }.should raise_error("You are not authorized to access this page.")
    end
  end
     
  context "POST create" do
    it "creates a new artwork for an admin" do
      login_admin
      post :create, :artwork => {:title => "test new artwork", :year => 1950}
      new_artwork = assigns(:artwork)
      response.should redirect_to new_artwork
      flash[:notice].should == "Artwork was successfully created."
      new_artwork.title.should == "test new artwork"
      new_artwork.year.should == 1950
    end
    
    it "doesn't create a new artwork for a user" do
      login_user
      lambda { post :create, :artwork => {:title => "Nebula", :year => 1965} }.should raise_error("You are not authorized to access this page.")
    end
  end
end
