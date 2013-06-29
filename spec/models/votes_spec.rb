require 'spec_helper'

describe Vote do
  before(:all) do

  end
  context "validations" do
	  it "has a valid factory" do
	  	FactoryGirl.build(:vote).should be_valid
	  end

	  it "is invalid without an associated poll option" do
	  	vote = FactoryGirl.build(:vote, :poll_option=>nil)
	  	vote.should_not be_valid
	  end
	  it "is invalid without a user" do
	  	FactoryGirl.build(:vote, :user=>nil).should_not be_valid
	  end
  end

  it "is able to clear previous votes" do
    poll = FactoryGirl.create(:poll)
    poll_option1 = FactoryGirl.create(:poll_option, :poll=>poll)
    poll_option2 = FactoryGirl.create(:poll_option, :poll=>poll)
    user = FactoryGirl.create(:user)
    vote = FactoryGirl.create(:vote, :poll_option=>poll_option1, :user=>user)
    poll_option1.votes.count.should == 1
    poll_option2.votes.count.should == 0

    vote2 = FactoryGirl.build(:vote, :user=>user, :poll_option=>poll_option2)
    vote2.save
    
    poll_option1.votes.count.should == 0
    poll_option2.votes.count.should == 1
  end

  it "can find if a user voted for a poll option" do
    user = FactoryGirl.create(:user)
    poll = FactoryGirl.create(:poll, :user=>user)
    poll_option = FactoryGirl.create(:poll_option, :poll=>poll)
    vote = FactoryGirl.create(:vote, :user=>user, :poll_option=>poll_option) 
    user.voted_for?(poll_option).should == true
  end
  
  it "will not submit a vote unless the associated poll is open" do
    user = FactoryGirl.create(:user)
    poll = FactoryGirl.create(:closed_poll, :user=>user)
    poll_option = FactoryGirl.create(:poll_option, :poll=>poll)
    vote = FactoryGirl.build(:vote, :user=>user, :poll_option=>poll_option) 
    vote.should_not be_valid
  end

  
end
