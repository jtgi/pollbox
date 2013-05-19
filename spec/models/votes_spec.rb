require 'spec_helper'

describe Votes do
	it "has a valid factory" do
		FactoryGirl.build(:vote).should be_valid
	end
	it "is invalid without an associated poll option" do
		vote = FactoryGirl.build(:vote, :poll=>nil)
		vote.should_not be_valid
	end
	it "is invalid without a user" do
		FactoryGirl.build(:vote, :user=>nil).should_not be_valid
	end
end
