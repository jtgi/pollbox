require 'spec_helper'
describe "Logins" do
  describe "GET /logins" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
			user = FactoryGirl.create(:user)
			user_json = {:format=>'json', :user=>{:email=>user.email, :password=>user.password}}
      post "/users/sign_in", user_json
    end
  end
end

