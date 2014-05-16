require 'spec_helper'

describe SidebarCell do

  context "cell instance" do
    subject { cell(:sidebar) }

    it { should respond_to(:folders) }
  end

  context "cell rendering" do
    context "rendering folders" do
      subject { render_cell(:sidebar, :folders) }

      it { should include "Sidebar#folders" }
      it { should include "Find me in app/cells/sidebar/folders.html" }
    end
  end

end
