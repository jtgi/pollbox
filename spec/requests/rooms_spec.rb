require 'spec_helper'
include Devise::TestHelpers
include Rack::Test::Methods

describe "Rooms" do
	
		before(:all) do
			@user = User.create(:first_name=>"Chris", :last_name=>"Zhu", :email=>"chris@example.com", :password=>"password", :password_confirmation=>"password")
			@user.save
			@room = Room.new(:name=>"Room", :maximum_registrants=>200, :description=>"Description")
			@room.owner_id = @user.id
			@room.save
			@registration = Registration.new
			@registration.user_id = @user.id
			@registration.room_id = @room.id
			@registration.save
		end
	
  describe "GET /rooms" do
    it "works! (now write some real specs)" do
			sign_in(@user)
      get "/rooms.json"
			response.body.should include("room")
    end
  end
end
