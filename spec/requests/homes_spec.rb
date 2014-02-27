# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Homes" do
  #let(:base_title) { "学术交流平台" }
  
  describe "GET /" do
    
    before { visit root_path }
    subject { page }
    it { should have_content('学术文档云平台') }
    it { should have_title("学术交流平台") }
    it { should_not have_title('| Home') }
  end
  
  describe "department" do
    before {visit root_path}
    let(:department){FactoryGirl.create(:department)}
    subject {page}
    it { should_not have_content(department.name)}
  end
end
