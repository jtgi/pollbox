require 'spec_helper'
include Devise::TestHelpers

describe RoomsController do

   
  describe "user is able to view all their rooms" do
    @user = FactoryGirl.create(:user)
    sign_in @user
    room = FactoryGirl.create(:room)
    FactoryGirl.create(:subscription, :room => room, :user=>@user)
    get :index
    assigns(:rooms).should eq([room])
  end

end
