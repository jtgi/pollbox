require "spec_helper"
include Devise::TestHelpers
include Rack::Test::Methods

describe "Headers" do
  it "should do something" do
    get "/rooms.json", nil, {"HTTP_ACCEPT"=>"json"}
  end
end
