require 'spec_helper'

describe AdminHeaderCell do

  context "cell instance" do
    subject { cell(:admin_header) }

    it { should respond_to(:userinfo) }
  end

  context "cell rendering" do
    context "rendering userinfo" do
      subject { render_cell(:admin_header, :userinfo) }

      it { should have_selector("h1", :content => "AdminHeader#userinfo") }
      it { should have_selector("p", :content => "Find me in app/cells/admin_header/userinfo.html") }
    end
  end

end
