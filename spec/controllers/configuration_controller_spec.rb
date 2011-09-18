require 'spec_helper'

describe ConfigurationController do
  include Devise::TestHelpers

  context "GET edit" do
    it "fails for a non admin user" do
      user = login_user
      expect { get :edit }.to raise_error(CanCan::AccessDenied)
    end
 
    it "succeeds for an admin" do
      user = login_admin
      get :edit
      response.should render_template :edit
    end
  end
 
  context "PUT update" do 
    it "fails for a non admin user" do
      user = login_user
      expect { put :update, :configuration => {:biography_content => "grilled cheese"}}.to raise_error(CanCan::AccessDenied)
    end
 
    it "succeeds for an admin" do
      user = login_admin
      put :update, :configuration => {:biography_content => "grilled cheese"}
      flash[:notice].should == "Successfully updated configuration"
      Configuration.get("biography_content").should == "grilled cheese"      
    end
  end
end
