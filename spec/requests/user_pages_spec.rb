require 'spec_helper'

describe "User pages" do

  subject { page }

  

  describe "signin" do
    before { visit root_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('div.alert.alert-error', text: 'Please enter a valid username or email') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Username or email", with: user.name
        fill_in "Password",          with: user.password
        click_button "Sign in"
      end

      it { should have_content(user.name) }
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Edit Profile") }
    end

    describe "with invalid information" do
      before { click_button "Submit" }

      it { should have_content('error') }
    end
  end
end