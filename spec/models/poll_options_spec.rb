require 'spec_helper'

describe PollOption do
	before(:all) do
		@user = FactoryGirl.create(:user)
		@room = FactoryGirl.create(:room)
		@poll = FactoryGirl.create(:poll, :user=>@user, :room=>@room)
	end
	it "has a valid factory" do
		FactoryGirl.build(:poll_option).should be_valid
	end

	it "is invalid without an associated poll" do
		poll_option = FactoryGirl.build(:poll_option, :poll=>nil)
		poll_option.should_not be_valid
		poll_option.poll = @poll
		poll_option.should be_valid
	end


	it "is invalid without an option" do
		FactoryGirl.build(:poll_option, :option=>"").should_not be_valid
		FactoryGirl.build(:poll_option, :option=>nil).should_not be_valid
	end
end
