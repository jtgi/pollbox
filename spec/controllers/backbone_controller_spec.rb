require 'spec_helper'

describe BackboneController do

  describe "GET 'app'" do
    it "returns http success" do
      get 'app'
      response.should be_success
    end
  end

end
