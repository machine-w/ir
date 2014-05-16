require 'spec_helper'

describe HeaderCell do

  context "cell instance" do
    subject { cell(:header) }

    it { should respond_to(:usertitle) }
  end

  context "cell rendering" do
    context "rendering usertitle" do
      subject { render_cell(:header, :usertitle) }

      it { should include "Header#usertitle" }
      it { should include "Find me in app/cells/header/usertitle.html" }
    end
  end

end
