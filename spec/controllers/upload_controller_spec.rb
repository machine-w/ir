require 'spec_helper'

describe UploadController do

  describe "GET 'serve'" do
    it "returns http success" do
      get 'serve'
      response.should be_success
    end
  end

end
