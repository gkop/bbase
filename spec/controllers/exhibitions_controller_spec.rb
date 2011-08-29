require 'spec_helper'

describe ExhibitionsController do
  include Devise::TestHelpers
    
  before :each do
    @gallery = Factory(:exhibition)
  end

  context "POST add" do
    before :each do
      @artwork = Factory(:artwork)
      @gallery.artworks << @artwork
    end

    it "adds an artwork to a user's own exhibition" do
      user = login_user
      user.exhibitions << @gallery
 
      post :add, :id => @gallery.id, :artwork_id => @artwork.id, :format => :html
      response.should redirect_to @artwork
      artwork = assigns(:artwork)
      artwork.should == @artwork

      flash[:notice].should == "Added "+@artwork.title+" to "+@gallery.name
      @gallery.reload
      @gallery.artworks.count.should == 1
      @gallery.artworks[0].should == artwork 
    end
    
    it "doesn't add an artwork to another user's exhibition" do
      user = login_user
      Factory(:user).exhibitions << @gallery
 
      lambda { post :add, :id => @gallery.id, :artwork_id => @artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
    
    it "doesn't add an artwork to an orphaned exhibition" do
      user = login_user
      lambda { post :add, :id => @gallery.id, :artwork_id => @artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end
  
  context "POST remove" do
    before :each do
      @artwork = Factory(:artwork)
      @gallery.artworks << @artwork
    end

    it "removes an artwork from a user's own exhibition" do
      user = login_user
      user.exhibitions << @gallery
      @artwork.exhibitions.count.should == 1
      @gallery.artworks.count.should == 1
  
      post :remove, :id => @gallery.id, :artwork_id => @artwork.id, :format => :html
      response.should redirect_to @gallery
      exhibition = assigns(:exhibition)
      
      flash[:notice].should == "Removed "+@artwork.title+" from "+@gallery.name
      @artwork.reload
      @artwork.exhibitions.count.should == 0
      exhibition.artworks.count.should == 0
    end
    
    it "doesn't remove an artwork from another user's exhibition" do
      user = login_user
      Factory(:user).exhibitions << @gallery
      lambda { post :remove, :id => @gallery.id, :artwork_id => @artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
    
    it "doesn't remove an artwork from an orphaned exhibition" do
      user = login_user
      lambda { post :remove, :id => @gallery.id, :artwork_id => @artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "GET index" do
    it "displays a list of all exhibitions for user" do
      login_user
      get :index, :format => :html
      response.should render_template :index
      assigns(:exhibitions).size.should == Exhibition.non_empty.count
    end
    
    it "doesn't display a list of all exhibitions for guest" do
      get :index, :format => :html
      response.should redirect_to new_user_session_path
    end
  end

  context "GET show" do
    it "shows a specific exhibition for user" do
      login_user
      get :show, :id => @gallery.id, :format => :html
      response.should render_template :show
      assigns(:exhibition).should == @gallery 
    end

    it "doesn't show a specific exhibition for guest" do
      get :show, :id => @gallery.id, :format => :html
      response.should redirect_to new_user_session_path
    end
  end

  context "GET new" do
    it "displays the new exhibition form for user" do
      login_user
      get :new, :format => :html
      response.should render_template :new
      assigns(:exhibition).should_not == nil
    end
    
    it "doesn't display the new exhibition form for guest" do
      get :new, :format => :html
      response.should redirect_to new_user_session_path
    end
  end
  
  context "GET edit" do
    it "doesn't display the edit gallery form for user that's not the owner" do
      login_user
      lambda { get :edit, :id => @gallery.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
    
    it "shows the edit gallery form for the owner" do
      user = login_user
      user.exhibitions << @gallery
      get :edit, :id => @gallery.id, :format => :html
      response.should render_template :edit
    end
    
    it "shows the edit gallery form for an admin" do
      user = login_admin
      get :edit, :id => @gallery.id, :format => :html
      response.should render_template :edit
    end
  end

  context "PUT update" do

    it "assigns a gallery to the homepage for admin" do
      login_admin
      put :update, :id => @gallery.id, :format => :html, :exhibition => {:assigned_to_homepage => true}
      response.should redirect_to @gallery
      flash[:notice].should == "Gallery was successfully updated"
      exhibition = assigns(:exhibition)
      exhibition.id.should == @gallery.id
      exhibition.is_on_homepage?.should == true
    end
    
    it "doesn't assign an exhibition to the homepage for user" do
      user = login_user
      user.exhibitions << @gallery
      lambda { put :update, :id => @gallery.id, :format => :html, :exhibition => {:assigned_to_homepage => true} }.should raise_error("You are not authorized to access this page.")
    end

    it "marks a gallery as curated for admin" do
      login_admin
      put :update, :id => @gallery.id, :format => :html, :exhibition => {:curated => true}
      response.should redirect_to @gallery
      flash[:notice].should == "Gallery was successfully updated"
      exhibition = assigns(:exhibition)
      exhibition.id.should == @gallery.id
      exhibition.curated?.should == true
    end
    
    it "doesn't mark a gallery as curated for non-admin gallery owner" do
      user = login_user
      user.exhibitions << @gallery
      lambda { put :update, :id => @gallery.id, :format => :html, :exhibition => {:curated => true} }.should raise_error("You are not authorized to access this page.")
    end

    it "allows the owner to change the name" do
      user = login_user
      user.exhibitions << @gallery
      @gallery.save!
      put :update, :id => @gallery.id, :format => :html, :exhibition => {:name => "Hoss"}
      response.should redirect_to @gallery
    end

    it "doesn't allow user that's not the owner to change the name" do
      login_user
      lambda { put :update, :id => @gallery.id, :format => :html, :exhibition => {:name => "Wahacha"} }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "DELETE destroy" do
    it "destroys a user's own exhibition" do
      user = login_user
      user.exhibitions << @gallery
      delete :destroy, :id => @gallery.id, :format => :html
      response.should redirect_to exhibitions_path
      Exhibition.all(:conditions => {:id => @gallery.id}).count.should == 0
      flash[:notice].should == "Deleted exhibition "+@gallery.name
    end
    
    it "doesn't destroy another user's exhibition" do
      user = login_user
      Factory.create(:user).exhibitions << @gallery
      lambda { delete :destroy, :id => @gallery.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end

    it "doesn't destroy an orphaned exhibition" do
      user = login_user
      lambda { delete :destroy, :id => @gallery.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end
     
  context "POST create" do
    it "creates a new exhibition for a user" do
      login_user
      post :create, :exhibition => {:name => "my gallery"}
      response.should redirect_to assigns(:exhibition)
      flash[:notice].should == "Gallery was successfully created"
    end
    
    it "doesn't create a new exhibition for a guest" do
      post :create, :exhibition => {:name => "Favorites"}
      response.should redirect_to new_user_session_path
    end
   
  end
end
