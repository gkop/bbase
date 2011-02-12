require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  before (:each) do
    @user = Factory.create(:user)
    sign_in @user
  end

  context "GET index" do
    it "displays a list of all users" do
      5.times do
        Factory.create(:user)
      end  
      get :index, :format => :html
      response.should be_success
      response.should render_template :index
      users = assigns(:users)
      users.size.should == 6
    end
  end

  context "GET show" do
    it "shows a specific user" do
      new_user = Factory.create(:user)
      get :show, :id => new_user.id, :format => :html
      response.should be_success
      response.should render_template :show
      user = assigns(:user)
      user.should == new_user
    end
  end

  # other methods tested by devise

end
