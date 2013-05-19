require 'spec_helper'

describe PollOption do
	it "has a valid factory" do
		Factory.build(:poll_option).should be_valid
	end
	it "is invalid without an associated poll" do
		factory = Factory.build(:poll_option, :poll=>nil)
		factory.should_not be_valid
		factory.poll = @poll
		factory.should be_valid
	end

end
