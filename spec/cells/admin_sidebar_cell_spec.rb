require 'spec_helper'

describe AdminSidebarCell do

  context "cell instance" do
    subject { cell(:admin_sidebar) }

    it { should respond_to(:folders) }
  end

  context "cell rendering" do
    context "rendering folders" do
      subject { render_cell(:admin_sidebar, :folders) }

      it { should have_selector("h1", :content => "AdminSidebar#folders") }
      it { should have_selector("p", :content => "Find me in app/cells/admin_sidebar/folders.html") }
    end
  end

end
