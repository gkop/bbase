require 'spec_helper'

describe ResourcesController do
  include Devise::TestHelpers

  let(:new_resource) {FactoryGirl.create(:writing)}

  context "GET index" do
    it "displays a list of all resources for user" do
      login_user
      2.times {FactoryGirl.create(:writing)}
      get :index
      response.should render_template :index
      assigns(:resources).size.should == 2
    end

    it "displays a list of all resources for guest" do
      get :index
      response.should render_template :index
    end
  end

  context "GET show" do
    it "shows a specific resource for user" do
      login_user
      get :show, :id => new_resource.id
      response.should render_template :show
      assigns(:resource).should == new_resource
    end

    it "shows specific resource for guest" do
      get :show, :id => new_resource.id
      response.should render_template :show
      assigns(:resource).should == new_resource
    end
  end

  context "GET new" do
    it "displays the new resource form for admin" do
      login_admin
      get :new, :tag => "writing"
      response.should render_template :new
      assigns(:resource).should_not be_blank
    end

    it "doesn't display the new resource form for user" do
      login_user
      lambda {get :new}.should raise_error("You are not authorized to access this page.")
    end
  end

  context "GET edit" do
    it "displays the edit resource form for admin" do
      login_admin
      get :edit, :id => new_resource.id
      response.should render_template :edit
      assigns(:resource).should == new_resource
    end

    it "doesn't display the edit resource form for user" do
      login_user
      lambda { get :edit, :id => new_resource.id }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "PUT update" do
    it "updates a resource for admin" do
      login_admin
      put :update, :id => new_resource.id, :resource => {:title => "test update resource"}
      resource = assigns(:resource)
      resource.title.should == "test update resource"
      response.should redirect_to resource_path(new_resource.id)
      flash[:notice].should == "Writing was successfully updated."
    end

    it "doesn't update a resource for user" do
      login_user
      lambda { put :update, :id => new_resource.id, :resource => {:title => "test update resource"} }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "DELETE destroy" do
    it "destroys a resource for an admin" do
      login_admin
      delete :destroy, :id => new_resource.id
      response.should redirect_to resources_path(:tags => "writing")
      Resource.count.should == 0
      flash[:notice].should == "Deleted writing "+new_resource.title
    end

    it "doesn't destroy a resource for a user" do
      login_user
      lambda { delete :destroy, :id => new_resource.id }.should raise_error("You are not authorized to access this page.")
    end
  end

  context "POST create" do
    it "creates a new resource for an admin" do
      login_admin
      post :create, :resource => {:title => "test new response",
                                  :tags => "response"}
      new_resource = assigns(:resource)
      response.should redirect_to new_resource
      flash[:notice].should == "Response was successfully created."
      new_resource.title.should == "test new response"
    end

    it "doesn't create a new resource for a user" do
      login_user
      lambda { post :create, :resource => {:title => "test new response",
        :tags => "response"} }.should raise_error("You are not authorized to access this page.")
    end
  end
end
