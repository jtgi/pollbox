require 'spec_helper'

describe UsersController, :type=>:controller do
  include Devise::TestHelpers

  render_views

  context "not logged in" do
    it "creates a new user when not logged in" do
      lambda {
        get :user, :format=>:json
      }.should change(User, :count).by(1)
    end
  end

end
