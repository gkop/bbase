require 'spec_helper'

describe ExhibitionsController do
  include Devise::TestHelpers

  context "POST add" do
    it "adds an artwork to a user's own exhibition" do
      new_artwork = Factory.create(:artwork)
      
      user = login_user
      new_exhibition = Factory.create(:exhibition, :artworks => [new_artwork])
      user.exhibitions << new_exhibition
 
      post :add, :id => new_exhibition.id, :artwork_id => new_artwork.id, :format => :html
      response.should be_redirect
      response.should redirect_to new_artwork
      artwork = assigns(:artwork)
      artwork.should == new_artwork

      flash[:notice].should == "Added "+new_artwork.title+" to "+new_exhibition.name
      new_exhibition.reload
      new_exhibition.artworks.count.should == 1
      new_exhibition.artworks[0].should == artwork 
    end
    
    it "doesn't add an artwork to another user's exhibition" do
      new_artwork = Factory.create(:artwork)
      
      user = login_user
      new_exhibition = Factory.create(:exhibition, :artworks => [new_artwork])
      Factory.create(:user).exhibitions << new_exhibition
 
      lambda { post :add, :id => new_exhibition.id, :artwork_id => new_artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
    
    it "doesn't add an artwork to an orphaned exhibition" do
      new_artwork = Factory.create(:artwork)
      
      user = login_user
      new_exhibition = Factory.create(:exhibition, :artworks => [new_artwork])
 
      lambda { post :add, :id => new_exhibition.id, :artwork_id => new_artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end
  
  context "POST remove" do
    it "removes an artwork from a user's own exhibition" do
      new_artwork = Factory.create(:artwork)
      
      user = login_user
      new_exhibition = Factory.create(:exhibition, :artworks => [new_artwork])
      user.exhibitions << new_exhibition
      new_artwork.exhibitions.count.should == 1
      new_exhibition.artworks.count.should == 1
  
      post :remove, :id => new_exhibition.id, :artwork_id => new_artwork.id, :format => :html
      response.should be_redirect
      response.should redirect_to new_exhibition
      exhibition = assigns(:exhibition)
      
      flash[:notice].should == "Removed "+new_artwork.title+" from "+new_exhibition.name
      new_artwork.reload
      new_artwork.exhibitions.count.should == 0
      exhibition.artworks.count.should == 0
    end
    
    it "doesn't remove an artwork from another user's exhibition" do
      new_artwork = Factory.create(:artwork)
      
      user = login_user
      new_exhibition = Factory.create(:exhibition, :artworks => [new_artwork])
      user.exhibitions << new_exhibition
      Factory.create(:user).exhibitions << new_exhibition
 
      lambda { post :remove, :id => new_exhibition.id, :artwork_id => new_artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
    
    it "doesn't remove an artwork from an orphaned exhibition" do
      new_artwork = Factory.create(:artwork)
      
      user = login_user
      new_exhibition = Factory.create(:exhibition, :artworks => [new_artwork])
      user.exhibitions << new_exhibition
      Factory.create(:user).exhibitions << new_exhibition
 
      lambda { post :remove, :id => new_exhibition.id, :artwork_id => new_artwork.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "GET index" do
    it "displays a list of all exhibitions for user" do
      login_user
      5.times do
        Factory.create(:exhibition)
      end  
      get :index, :format => :html
      response.should be_success
      response.should render_template :index
      exhibitions = assigns(:exhibitions)
      exhibitions.size.should == 6 # including the users' favorites
    end
    
    it "doesn't display a list of all exhibitions for guest" do
      get :index, :format => :html
      response.should_not be_success
      response.should redirect_to new_user_session_path
    end
  end

  context "GET show" do
    it "shows a specific exhibition for user" do
      login_user
      new_exhibition = Factory.create(:exhibition)
      get :show, :id => new_exhibition.id, :format => :html
      response.should be_success
      response.should render_template :show
      exhibition = assigns(:exhibition)
      exhibition.should == new_exhibition 
    end

    it "doesn't show a specific exhibition for guest" do
      new_exhibition = Factory.create(:exhibition)
      get :show, :id => new_exhibition.id, :format => :html
      response.should_not be_success
      response.should redirect_to new_user_session_path
    end
  end

  context "GET new" do
    it "displays the new exhibition form for user" do
      login_user
      get :new, :format => :html
      response.should be_success
      response.should render_template :new
      exhibition = assigns(:exhibition)
      exhibition.should_not == nil
    end
    
    it "doesn't display the new exhibition form for guest" do
      get :new, :format => :html
      response.should_not be_success
      response.should redirect_to new_user_session_path
    end
  end
  
  context "GET edit" do
    it "doesn't display the edit gallery form for user that's not the owner" do
      login_user
      new_exhibition = Factory.create(:exhibition)
      lambda { get :edit, :id => new_exhibition.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
    
    it "shows the edit gallery form for the owner" do
      user = login_user
      new_gallery = Factory.build(:exhibition)
      user.exhibitions << new_gallery
      new_gallery.save!
      get :edit, :id => new_gallery.id, :format => :html
      response.should be_success
      response.should render_template :edit
    end
  end

  context "PUT update" do
    it "assigns an exhibition to the homepage for admin" do
      login_admin
      new_exhibition = Factory.create(:exhibition)
      put :update, :id => new_exhibition.id, :format => :html, :exhibition => {:assigned_to_homepage => true}
      response.should be_redirect
      response.should redirect_to new_exhibition
      flash[:notice].should == "Gallery was successfully updated"
      exhibition = assigns(:exhibition)
      exhibition.id.should == new_exhibition.id
      exhibition.is_on_homepage?.should == true
    end
    
    it "doesn't assign an exhibition to the homepage for user" do
      user = login_user
      new_exhibition = Factory.create(:exhibition)
      user.exhibitions << new_exhibition
      lambda { put :update, :id => new_exhibition.id, :format => :html, :exhibition => {:assigned_to_homepage => true} }.should raise_error("You are not authorized to access this page.")
    end

    it "allows the owner to change the name" do
      user = login_user
      new_gallery = Factory.build(:exhibition)
      user.exhibitions << new_gallery
      new_gallery.save!
      put :update, :id => new_gallery.id, :format => :html, :exhibition => {:name => "Hoss"}
      response.should be_redirect
      response.should redirect_to new_gallery
    end

    it "doesn't allow user that's not the owner to change the name" do
      user = login_user
      new_gallery = Factory.create(:exhibition)
      lambda { put :update, :id => new_gallery.id, :format => :html, :exhibition => {:name => "Wahacha"} }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "DELETE destroy" do
    it "destroys a user's own exhibition" do
      user = login_user
      new_exhibition = Factory.create(:exhibition)
      user.exhibitions << new_exhibition
      delete :destroy, :id => new_exhibition.id, :format => :html
      response.should be_redirect
      response.should redirect_to exhibitions_path
      Exhibition.all(:conditions => {:id => new_exhibition.id}).count.should == 0
      flash[:notice].should == "Deleted exhibition "+new_exhibition.name
    end
    
    it "doesn't destroy another user's exhibition" do
      user = login_user
      new_exhibition = Factory.create(:exhibition)
      Factory.create(:user).exhibitions << new_exhibition
      lambda { delete :destroy, :id => new_exhibition.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end

    it "doesn't destroy an orphaned exhibition" do
      user = login_user
      new_exhibition = Factory.create(:exhibition)
      lambda { delete :destroy, :id => new_exhibition.id, :format => :html }.should raise_error("You are not authorized to access this page.")
    end
  end
     
  context "POST create" do
    it "creates a new exhibition for a user" do
      login_user
      exhibition_name = "test exhibition"
      exhibition = mock_model(Exhibition)
      Exhibition.should_receive(:new).exactly(2).times.and_return(exhibition)
      exhibition.should_receive(:attributes=)
      exhibition.should_receive(:metadata)
      exhibition.should_receive(:metadata=)
      exhibition.should_receive(:user)
      exhibition.should_receive(:user=)
      exhibition.should_receive(:save).exactly(2).times

      post :create, :exhibition => {:name => exhibition_name}
      #TODO uncomment once rspec fixes this
      #response.should be_redirect
      #response.should redirect_to exhibition
      #flash[:notice].should == "Exhibition was successfully created."
    end
    
    it "doesn't create a new exhibition for a guest" do
      post :create, :exhibition => {:name => "Favorites"}
      response.should_not be_success
      response.should redirect_to new_user_session_path
    end
   
  end
end
