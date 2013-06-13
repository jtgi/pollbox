require 'spec_helper'

describe RoomsController, :type=>:controller do
  include Devise::TestHelpers

  render_views
 
  let(:room) {FactoryGirl.create(:room)}
  subject {room}
  let(:user) { FactoryGirl.create(:user) }

  context "not logged in" do
    it "does allow get" do
    lambda {
      post :create, :room=>{:name=>"chris zhu"}, :format=>:json
      response.status.should eq(403)
      }.should change(Room, :count).by(0)
    end
  end
  context "logged in" do
    it "allows creation of room" do
      sign_in(user)
      lambda {
        post :create, {:format => 'json',:room=>{:name=>"Room Name"}}
      }.should change(Room, :count).by(1)
      response.status.should == 200

    end
  end
end
