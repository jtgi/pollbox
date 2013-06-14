require 'spec_helper'

describe RoomsController, :type=>:controller do
  include Devise::TestHelpers

  render_views
 
  user = FactoryGirl.create(:user)
  
  room = FactoryGirl.create(:room)
  FactoryGirl.create(:subscription, :room=>room, :user=>user)
  subject {room}

  context "not logged in" do
    it "does allow get" do
      get :index, :format=>:json
      response.status.should eq(401), "#{response.body}"
    end
  end
  context "logged in" do
    before(:each) do
      sign_in(user)
    end
    it "allows creation of room" do
      lambda {
        post :create, {:format => 'json',:room=>{:name=>"Room Name"}}
      }.should change(Room, :count).by(1)
      response.status.should == 200

    end

    it "allows retrieval of a room" do
      get :show, :id=>room.id, :format=>:json
      response.status.should == 200
    end
  end
end
