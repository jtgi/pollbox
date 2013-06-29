require 'spec_helper'

describe PollsController, :type=>:controller do
  include Devise::TestHelpers
  render_views
  
  let(:room) {FactoryGirl.create(:room)}
  let(:poll) {FactoryGirl.create(:poll, :room=>room) }
  subject {poll}
  let(:user) { FactoryGirl.create(:user) }

  before(:all) do
    FactoryGirl.create(:owned_subscription, :user=>user, :room=>room)
  end

  context "user is not logged in" do
    it "returns a 401 when trying to request" do
    lambda {
        post :create, :poll=>{:title=>"Poll Stuff"}, :format=>:json
        response.status.should eq(401)
      }.should change(Poll, :count).by(0)
    end
  end

  context "user is logged in" do
    context "creating" do
      it "could create polls" do
        sign_in(user)
        poll = Poll.new({:title=>"Poll Stuff"})
        lambda {
          post :create, :poll=>{:title=> poll.title}, :format=>:json, :room_id=>room.id
          response.status.should eq(200)
        }.should change(Poll, :count).by(1)
        room.polls.count.should == 1
      end
    end
    
    context "reading" do
      it "could read polls" do
        sign_in(user)
        user.is_subscribed_to(poll.room.id).should == true
        get :show, id:poll.id, :format=>:json
      end
    end

    context "updating" do
      it "could update polls"
    end

    context "destroying" do
      it "could destroy a poll"
    end

    context "using realtime features" do
      it "has working routes" do
        
      end
    end
  end
end
