require 'spec_helper'

describe ExhibitionsController do
  include Devise::TestHelpers

  context "POST add" do
    it "adds an artwork to an exhibition" do
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
  end
  
  context "POST remove" do
    it "removes an artwork from an exhibition" do
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
  end

  context "GET index" do
    it "displays a list of all exhibitions" do
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
  end

  context "GET show" do
    it "shows a specific exhibition" do
      login_user
      new_exhibition = Factory.create(:exhibition)
      get :show, :id => new_exhibition.id, :format => :html
      response.should be_success
      response.should render_template :show
      exhibition = assigns(:exhibition)
      exhibition.should == new_exhibition 
    end
  end

  context "GET new" do
    it "displays the new exhibition form" do
      login_user
      get :new, :format => :html
      response.should be_success
      response.should render_template :new
      exhibition = assigns(:exhibition)
      exhibition.should_not == nil
    end
  end
  
  context "GET edit" do
    it "displays the edit exhibition form" do
      pending "need an edit view" do
        login_user
        new_exhibition = Factory.create(:exhibition)
        get :edit, :id => new_exhibition.id, :format => :html
        response.should be_success
        response.should render_template :edit
        exhibition = assigns(:exhibition)
        exhibition.should == new_exhibition
      end
    end
  end

  context "PUT update" do
    it "updates assigns an exhibition to the homepage" do
      login_admin
      new_exhibition = Factory.create(:exhibition)
      put :update, :id => new_exhibition.id, :format => :html, :exhibition => {:assigned_to_homepage => true}
      response.should be_redirect
      response.should redirect_to new_exhibition
      flash[:notice].should == "Exhibition was successfully updated."
      exhibition = assigns(:exhibition)
      exhibition.id.should == new_exhibition.id
      exhibition.is_on_homepage?.should == true
    end
  end

  context "DELETE destroy" do
    it "destroys an exhibition" do
      user = login_user
      new_exhibition = Factory.create(:exhibition)
      user.exhibitions << new_exhibition
      delete :destroy, :id => new_exhibition.id, :format => :html
      response.should be_redirect
      response.should redirect_to exhibitions_path
      Exhibition.all(:conditions => {:id => new_exhibition.id}).count.should == 0
      flash[:notice].should == "Deleted exhibition "+new_exhibition.name
    end
  end
     
  context "POST create" do
    it "creates a new exhibition" do
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
# uncomment once rspec fixes this
#      response.should be_redirect
 #     response.should redirect_to exhibition
  #    flash[:notice].should == "Exhibition was successfully created."
    end
  end
end
