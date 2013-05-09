require 'spec_helper'

describe RoomsController do
	include RSpec::Rails::ControllerExampleGroup
	#rabl requirement
	render_views

	#let(:room) { FactoryGirl.create(:room) }
	describe "GET index" do
		it "shows a list of rooms owned" do
		end
	end
	describe "GET /rooms/1.json" do
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

		context "when user owns room" do
			it "displays room attributes and owned property is true" do
				 room = FactoryGirl.create(:room)
				 sign_in room.user	
				 get :show, id: room.id
				 response.body.should include("room")
			end
		end

		context "when user is subscribed for room" do
			it "displays room attributes" 

		end

		context "when user is not registered" do
			it "gives an error" 
		end
	end

	describe "creating a new room" do
		json = {:format=>'json', :room=>{ :name=>"TestRoom", :description=>"Descript of testroom", :maximum_registrants=>200 }}	

		context "when not logged in" do
			it "should not allow a room to be created" do
				post :create, json
				Room.count.should == 0	
			end
		end

		context "when logged in" do
			it "should allow a room to be created" do
				user = FactoryGirl.create(:user)
				sign_in(user)	
				post :create, json
				Room.count.should == 1
			end
		end
	end
end
