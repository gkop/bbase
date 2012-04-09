require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  context "GET index" do
    it "displays a list of all users for user" do
      login_user
      2.times { FactoryGirl.create(:user) }
      get :index
      response.should render_template :index
      assigns(:users).size.should == 3
    end

    it "displays a list of all users for guest" do
      get :index
      response.should render_template :index
    end
  end

  context "GET show" do
    let(:new_user) { FactoryGirl.create(:user) }  

    it "shows a specific user for user" do
      login_user
      get :show, :id => new_user.id
      response.should render_template :show
      assigns(:user).should == new_user
    end

    it "shows a specific user for guest" do
      get :show, :id => new_user.id
      response.should render_template :show
      assigns(:user).should == new_user
    end
  end

  # other methods tested by devise

end
