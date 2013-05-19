require 'spec_helper'

describe Poll do
	before(:all) do
		@room = FactoryGirl.create(:room)
		@user = FactoryGirl.create(:user)
	end
	describe "validations" do
		it "has a valid factory" do
			FactoryGirl.build(:poll).should be_valid
		end

		it "is not valid without a room" do
			poll = FactoryGirl.build(:poll, :user=>nil, :room=>nil)
			poll.user = @user
			poll.should_not be_valid
			poll.room = @room
			poll.should be_valid
		end

		it "is not valid without a room" do
			poll = FactoryGirl.build(:poll, :user=>nil, :room=>nil)
			poll.room = @room
			poll.should_not be_valid
			poll.user = @user
			poll.should be_valid
		end

		it "is valid without a title" do
			FactoryGirl.build(:poll, :title=>"").should be_valid
		end

		it "is not valid without at least 2 poll options"
	end

	describe "querying" do
		it "can retrieve all polls associated with a certain room and user" do
			
			poll = FactoryGirl.create(:poll, :user=>@user, :room=>@room)
			@user.polls.first.should == poll
			@room.polls.first.should == poll
			
		end

	end
end
