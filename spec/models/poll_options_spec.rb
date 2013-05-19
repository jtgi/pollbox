require 'spec_helper'

describe PollOption do
	before(:all) do
		@user = FactoryGirl.create(:user)
		@room = FactoryGirl.create(:room)
		@poll = FactoryGirl.create(poll, user=>@user, room=>@room)
	end
	it "has a valid factory" do
		Factory.build(:poll_option).should be_valid
	end

	it "is invalid without an associated poll" do
		poll_option = FactoryGirl.build(:poll_option, :poll=>nil)
		poll_option.should_not be_valid
		poll_option.poll = @poll
		poll_option.should be_valid
	end

	it "can retrieve all poll options of a poll" do
		poll_option1 = FactoryGirl.create(:poll_option, poll=>@poll)
		poll_option2 = FactoryGirl.create(:poll_option, poll=>@poll)
		@poll.poll_options.first.should == poll_option1
		@poll.poll_options.count.should == 2
	end

	it "is invalid without a title" do
		FactoryGirl.build(:poll_option, :title=>"").should_not be_valid
		FactoryGirl.build(:poll_option, :title=>nil).should_not be_valid
	end
end
