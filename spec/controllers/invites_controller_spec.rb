require 'spec_helper'

describe InvitesController do

  context "GET new" do
    it "shows guest the request an invite form" do
      get :new, :format => :html
      response.should be_success
      response.should render_template :new
    end
  end
  
  context "POST create" do
    it "accepts invite request from guest" do
      get :create, :format => :html
      response.should be_success
      response.should render_template :create
    end
  end

end
