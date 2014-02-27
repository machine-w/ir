# -*- coding: utf-8 -*-
require 'spec_helper'

describe "UserPages" do
  subject {page}

  
  describe "signup" do
    before {visit new_user_registration_path}
    let(:commit) {"注册"}
    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button commit}.not_to change(User,:count)
      end
    end
    describe "with valid information" do
      before do
        fill_in "user[email]",with: "steve2008.ma1@gmail.com"
        fill_in "user[password]",with: "110918"
        fill_in "user[password_confirmation]", with: "110918"
        
      end
      it "should create a user"do
        expect {click_button commit}.to change(User,:count).by(1)
      end
    end

  end
end
