require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  context "GET index" do
    it "displays a list of all users for user" do
      login_user
      5.times do
        Factory.create(:user)
      end  
      get :index, :format => :html
      response.should be_success
      response.should render_template :index
      users = assigns(:users)
      users.size.should == 6
    end

    it "doesn't display a list of all users for guest" do
      get :index, :format => :html
      response.should_not be_success
      response.should redirect_to new_user_session_path
    end
  end

  context "GET show" do
    it "shows a specific user for user" do
      login_user
      new_user = Factory.create(:user)
      get :show, :id => new_user.id, :format => :html
      response.should be_success
      response.should render_template :show
      user = assigns(:user)
      user.should == new_user
    end

    it "doesn't show a specific user for guest" do
      new_user = Factory.create(:user)
      get :show, :id => new_user.id, :format => :html
      response.should_not be_success
      response.should redirect_to new_user_session_path
    end
  end

  # other methods tested by devise

end
