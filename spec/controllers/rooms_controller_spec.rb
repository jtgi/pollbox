require 'spec_helper'

describe RoomsController do
	include RSpec::Rails::ControllerExampleGroup
	#rabl requirement
	render_views
	let(:default_params) { {format: :json} }

	#let(:room) { FactoryGirl.create(:room) }
	describe "GET /rooms/1.json" do
		before(:all) do
			#@user = User.create(:first_name=>"Chris", :last_name=>"Zhu", :email=>"chris@example.com", :password=>"password", :password_confirmation=>"password")
			#@user.save
			#@room = Room.new(:name=>"Room", :maximum_registrants=>200, :description=>"Description")
			#@room.save
			#@registration = Registration.new
			#@registration.user_id = @user.id
			#@registration.room_id = @room.id
			#@registration.user_level = 3
			#@registration.save
		end

		context "when user owns room" do
			it "displays room attributes and owned property is true" do
				 user = FactoryGirl.create(:user)
				 room = FactoryGirl.create(:room)
				 FactoryGirl.create(:subscription, user: user, room: room, user_level: 3)
          
				 Room.find_by_id(room.id).name.should == room.name
				 room.users.first.should == user
				 user.rooms.first.should == room
					
				 sign_in(user)
				 env = Rack::MockRequest.env_for('/rooms/1', :method => 'GET', :HTTP_ACCEPT=>'application/json')
				 RoomsController.action(:show).call(env)

				 #request.env['HTTP_ACCEPT'] = 'application/json'
				 #get :show, :id=>room
				 #assigns(:room).should eq(room)
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
				init_count = Room.count
				post :create, json
				diff = Room.count - init_count
				diff.should == 0
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
