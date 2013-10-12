require 'spec_helper'

describe "Authentication" do
  
  subject { page }

  describe "signin" do

  	before { visit root_path }

  	it { should have_button('Sign in') }

  	describe "with invalid information" do
  	  before { click_button "Sign in" }

  	  it { should have_selector('div.alert.alert-error', text: 'Please enter a valid username or email') }
  	end

  	  describe "after visiting another page" do
        before { click_link "The Weekend" }
        it { should_not have_selector('div.alert.alert-error') }
      end

  	describe "with valid username" do
  	  let(:user) { FactoryGirl.create(:user) }
  	  before do
  	    fill_in "Username or email", with: user.name
  	    fill_in "Password", with: user.password
  	    click_button "Sign in"
  	  end

  	  it { should have_title(user.name) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_button('Sign in') }
      end
  	end

    describe "authorization" do
      describe "for non-signed-in users" do
        let(:user) { FactoryGirl.create(:user) }

        describe "in the Users controller" do

          describe "visiting the edit page" do
            before { visit edit_user_path(user) }
            it { should have_button('Sign in') }
          end

          describe "submitting to the update action" do
            before { patch user_path(user) }
            specify { expect(response).to redirect_to(root_path) }
          end
        end
      end
    end
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, name: "wrong", email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end