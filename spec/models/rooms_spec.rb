require 'spec_helper'
describe "Rooms Model" do
	before(:all) do
		@user = User.create(:email=>"test_chris@hotmail.com", :password=>"070227", :password_confirmation=>"070227")
		@user.save
	end

	describe "Creating a room" do
		it "is not valid without a name" do
			lambda {room = Room.create(:name=>"", :description=>"Room with no name")}.should change(Room, :count).by(0)
			lambda {room = Room.create(:name=>"TestRoom", :description=>"Room with no name")}.should change(Room, :count).by(1)
		end

		it "has a unique name" do
			room = Room.create(:name=>"TestRoom1", :description=>"Room description")
			room2 = Room.new(:name=>"TestRoom1", :description=>"haha")
			room2.should_not be_valid
			room2.name = "NewName"
			room2.should be_valid
		end
	end

	describe "Reading a room" do
		before(:all) do
			@room = Room.new(:name=>"Users Room", :description=>"Room with a name")
			@room.save
			lambda {
				registration = Subscription.new
				registration.user_level = 3
				registration.user = @user
				registration.room = @room 
				registration.should be_valid
				registration.save
			}.should change(Subscription, :count).by(1)
		end

		it "can find by id, name" do
			room_by_id = Room.find_by_id(@room.id)
			room_by_id.should == @room
			room_by_name = Room.find_by_name(@room.name)
			room_by_name.should == @room
		end

		it "can find all rooms owned by user" do
			@user.rooms.size.should == 1
			@user.rooms.first.should == @room 
			
		end
	end

	describe "Updating a room" do 
		
	end

	describe "Deleting a room" do 
	end

end
