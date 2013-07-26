require 'spec_helper'

describe UsersController, :type=>:controller do
  include Devise::TestHelpers

  render_views
  let(:user) { FactoryGirl.create(:user) }

  context "not logged in" do
    it "creates a new user when not logged in" do
      lambda {
        get :user, :format=>:json
      }.should change(User, :count).by(1)
    end
  end
  context "currently logged in" do
    it "returns the current user" do
      sign_in(user)
      get :user, :format=>:json
      response.status.should == 200
      JSON.parse(response.body)["id"].should == user.id
    end
  end
end
