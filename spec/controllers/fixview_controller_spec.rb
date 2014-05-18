require 'spec_helper'

describe FixviewController do

  describe "GET 'pubu'" do
    it "returns http success" do
      get 'pubu'
      response.should be_success
    end
  end

end
