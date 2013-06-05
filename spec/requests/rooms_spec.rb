require 'spec_helper'
include Devise::TestHelpers
include Rack::Test::Methods

describe "Rooms" do
	
		before(:all) do
      @user = FactoryGirl.create(:user, :email=>"chris_zhu@hotmail.com", :password=>"password", :password_confirmation=>"password")
      @room = FactoryGirl.create(:room, :name=>"Room")
      sub = FactoryGirl.create(:subscription, :user=>@user, :room=>@room)
		end
	
  describe "GET /rooms" do
    it "works! (now write some real specs)" do
      post("/users/sign_in", {:email=>"chris_zhu@hotmail.com", :password=>"password"}.to_json) 
    end
  end
end
