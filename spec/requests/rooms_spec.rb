require 'spec_helper'
include Devise::TestHelpers
include Rack::Test::Methods

describe "Rooms" do
	
		before(:all) do
    
		end
	
  describe "GET /rooms" do
    it "creating a new room" do
      post 'api/v1/rooms.json', :parameters=>{:room=>{:name=>"Christtopher"}}
      response.should be_success
    end
  end
end
