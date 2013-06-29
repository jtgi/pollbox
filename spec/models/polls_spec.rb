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
	
	describe "poll option analysis" do

		before(:all) do
			@poll = FactoryGirl.create(:poll, :user=>@user, :room=>@room)
		end

		it "can retrieve all poll options of a poll" do
			@poll_option1 = FactoryGirl.create(:poll_option, :poll=>@poll)
			@poll_option2 = FactoryGirl.create(:poll_option, :poll=>@poll)
			@poll.poll_options.first.should == poll_option1
			@poll.poll_options.count.should == 2
		end

		it "can deduce the number of votes for each option" do
			vote1 = FactoryGirl.create(:vote, :user=>@user, :poll_option=>@poll_option1)
		end

	end

end
