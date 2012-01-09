require 'spec_helper'

describe GalleriesController do
  include Devise::TestHelpers
    
  let(:artwork) { Factory(:artwork) }
  let(:gallery) do
    g = Factory(:gallery)
    g.artworks << artwork
    g
  end

  context "POST add" do

    it "adds an artwork to a user's own gallery" do
      user = login_user
      user.galleries << gallery
      post :add, :id => gallery.id, :artwork_id => artwork.id
      response.should redirect_to artwork
      assigns(:artwork).should == artwork

      flash[:notice].should == "Added "+artwork.title+" to "+gallery.name
      gallery.reload
      gallery.artworks.count.should == 1
      gallery.artworks.first.should == artwork 
    end
    
    it "doesn't add an artwork to another user's gallery" do
      user = login_user
      Factory(:user).galleries << gallery
 
      lambda { post :add, :id => gallery.id, :artwork_id => artwork.id }.should raise_error("You are not authorized to access this page.")
    end
    
    it "doesn't add an artwork to an orphaned gallery" do
      user = login_user
      lambda { post :add, :id => gallery.id, :artwork_id => artwork.id }.should raise_error("You are not authorized to access this page.")
    end
  end
  
  context "POST remove" do

    it "removes an artwork from a user's own gallery" do
      user = login_user
      user.galleries << gallery
      artwork.galleries.count.should == 1
      gallery.artworks.count.should == 1
  
      post :remove, :id => gallery.id, :artwork_id => artwork.id
      response.should redirect_to gallery
      assigns(:gallery).should == gallery
      
      flash[:notice].should == "Removed "+artwork.title+" from "+gallery.name
      artwork.reload.galleries.count.should == 0
      gallery.reload.artworks.count.should == 0
    end
    
    it "doesn't remove an artwork from another user's gallery" do
      user = login_user
      Factory(:user).galleries << gallery
      lambda { post :remove, :id => gallery.id, :artwork_id => artwork.id }.should raise_error("You are not authorized to access this page.")
    end
    
    it "doesn't remove an artwork from an orphaned gallery" do
      user = login_user
      lambda { post :remove, :id => gallery.id, :artwork_id => artwork.id }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "GET index" do
    it "displays a list of all galleries for user" do
      login_user
      get :index
      response.should render_template :index
      assigns(:galleries).size.should == Gallery.non_empty.count
    end
    
    it "displays a list of all galleries for guest" do
      get :index
      response.should render_template :index
      assigns(:galleries).size.should == Gallery.non_empty.count
    end
  end

  context "GET show" do
    it "shows a specific gallery for user" do
      login_user
      get :show, :id => gallery.id
      response.should render_template :show
      assigns(:gallery).should == gallery 
    end

    it "shows a specific gallery for guest" do
      get :show, :id => gallery.id
      response.should render_template :show
      assigns(:gallery).should == gallery 
    end
  end

  context "GET new" do
    it "displays the new gallery form for user" do
      login_user
      get :new
      response.should render_template :new
      assigns(:gallery).should be_present
    end
    
    it "doesn't display the new gallery form for guest" do
      get :new
      response.should redirect_to new_user_session_path
    end
  end
  
  context "GET edit" do
    it "doesn't display the edit gallery form for user that's not the owner" do
      login_user
      lambda { get :edit, :id => gallery.id }.should raise_error("You are not authorized to access this page.")
    end
    
    it "shows the edit gallery form for the owner" do
      user = login_user
      user.galleries << gallery
      get :edit, :id => gallery.id
      response.should render_template :edit
    end
    
    it "shows the edit gallery form for an admin" do
      user = login_admin
      get :edit, :id => gallery.id
      response.should render_template :edit
    end
  end

  context "PUT update" do

    it "assigns a gallery to the homepage for admin" do
      login_admin
      put :update, :id => gallery.id, :gallery => {:assigned_to_homepage => true}
      response.should redirect_to gallery
      flash[:notice].should == "Gallery was successfully updated"
      assigns(:gallery).should == gallery
      gallery.reload.is_on_homepage?.should be_true
    end
    
    it "doesn't assign an gallery to the homepage for user" do
      user = login_user
      user.galleries << gallery
      lambda { put :update, :id => gallery.id, :gallery => {:assigned_to_homepage => true} }.should raise_error("You are not authorized to access this page.")
      gallery.reload.is_on_homepage?.should be_false
    end

    it "marks a gallery as curated for admin" do
      login_admin
      put :update, :id => gallery.id, :gallery => {:curated => true}
      response.should redirect_to gallery
      flash[:notice].should == "Gallery was successfully updated"
      assigns(:gallery).should == gallery
      gallery.reload.curated?.should be_true
    end
    
    it "doesn't mark a gallery as curated for non-admin gallery owner" do
      user = login_user
      user.galleries << gallery
      lambda { put :update, :id => gallery.id, :gallery => {:curated => true} }.should raise_error("You are not authorized to access this page.")
      gallery.reload.curated?.should be_false
    end

    it "allows the owner to change the name" do
      user = login_user
      user.galleries << gallery
      put :update, :id => gallery.id, :gallery => {:name => "Hoss"}
      response.should redirect_to gallery
      gallery.reload.name.should  == "Hoss"
    end

    it "doesn't allow user that's not the owner to change the name" do
      login_user
      lambda { put :update, :id => gallery.id, :gallery => {:name => "Wahacha"} }.should raise_error("You are not authorized to access this page.")
      gallery.reload.name.should_not == "Wahacha"
    end
  end

  context "DELETE destroy" do
    it "destroys a user's own gallery" do
      user = login_user
      user.galleries << gallery
      delete :destroy, :id => gallery.id
      response.should redirect_to galleries_path
      Gallery.all(:conditions => {:id => gallery.id}).count.should == 0
      flash[:notice].should == "Deleted gallery "+gallery.name
    end
    
    it "doesn't destroy another user's gallery" do
      user = login_user
      Factory(:user).galleries << gallery
      lambda { delete :destroy, :id => gallery.id }.should raise_error("You are not authorized to access this page.")
      gallery.reload.should be_present
    end

    it "doesn't destroy an orphaned gallery" do
      user = login_user
      lambda { delete :destroy, :id => gallery.id }.should raise_error("You are not authorized to access this page.")
      gallery.reload.should be_present
    end
  end
     
  context "POST create" do
    it "creates a new gallery for a user" do
      login_user
      post :create, :gallery => {:name => "my gallery"}
      response.should redirect_to assigns(:gallery)
      flash[:notice].should == "Gallery was successfully created"
    end
    
    it "doesn't create a new gallery for a guest" do
      post :create, :gallery => {:name => "guest gallery"}
      response.should redirect_to new_user_session_path
    end
   
  end
end
