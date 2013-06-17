require 'spec_helper'

describe RoomsController, :type=>:controller do
  include Devise::TestHelpers

  render_views
 
  let(:room) {FactoryGirl.create(:room)}
  subject {room}
  let(:user) { FactoryGirl.create(:user) }

  before(:all) do
    FactoryGirl.create(:owned_subscription, :user=>user, :room=>room)
  end
  context "not logged in" do
    it "does allow get" do
    lambda {
      post :create, :room=>{:name=>"chris zhu"}, :format=>:json
      response.status.should eq(401)
      }.should change(Room, :count).by(0) end
  end
  context "logged in" do

    context "updating rooms" do
      it "can update room attributes" do
        sign_in(user)
        room_name = "New Room Name"
        room.name.should_not == room_name
        put :update, id:room.id, :room=>{:name=>"New Room Name"}, :format=>:json
        Room.find(room.id).name.should == room_name
      end
    end

    context "reading rooms" do
      it "is possible" do
        sign_in(user)
        get :index, user_id:user.id, :format=>:json
        response.status.should == 200
      end
    end

    context "creating rooms" do
      it "allows creation of room" do
        sign_in(user)
        lambda {
          post :create, {:format => 'json',:room=>{:name=>"Room Name"}}
        }.should change(Room, :count).by(1)
        response.status.should == 200
      end
    end
    
    context "destroying rooms" do
      it "is able to destroy rooms" do
        destroy_me = FactoryGirl.create(:room)
        FactoryGirl.create(:subscription, :user=>user, :room=>destroy_me)
        lambda {
          delete :destroy, id:destroy_me.id
        }.should change(Room, :count).by(-1)
      end
    end
  end
end
