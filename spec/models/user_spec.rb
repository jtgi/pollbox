require 'spec_helper'
describe User do
	it "has a valid factory" do
		FactoryGirl.build(:user).should be_valid
	end
	
	it "is invalid without a email and password" do
		FactoryGirl.build(:user, :email=>"").should_not be_valid
		FactoryGirl.build(:user, :password=>"").should_not be_valid
	end

	it "has a valid owns_room? method" do
		
	end

	it "has a valid voted_for? method" do
	end


	it "has a valid is_subscribed_to method" do
	end

	it "has a valid owns_question?" do
	end

	it "has a valid owns_answer?" do
	end


end
