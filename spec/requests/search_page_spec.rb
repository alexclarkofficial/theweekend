require 'spec_helper'

describe "search" do

  subject { page }

  describe "users index should have search field" do
    let(:user) { FactoryGirl.create(:user, name: "User") }
    before(:each) do
      5.times { FactoryGirl.create(:user) }
      FactoryGirl.create(:user, name: 'Alex')
      sign_in user
      visit users_path
    end

    it { should have_button('Search') }
    it { should have_field('Search') }

    describe "search should yield search results" do
      before do
        fill_in "Search", with: "Alex"
        click_button "Search"
      end

      it { should have_content 'Alex' }
      it { should_not have_content 'Person' }
    end
  end
end