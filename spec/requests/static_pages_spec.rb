require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do

    it "should have the content 'The Weekend'" do
      visit root_path
      expect(page).to have_content('The Weekend')
    end


    it "should have the title 'The Weekend'" do
      visit root_path
      expect(page).to have_title("The Weekend")
    end

    describe "for signed-in users" do
      let(:user) {FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:weekend, user: user, week: FactoryGirl.create(:week, date: Date.new(2013,10,20)))
        FactoryGirl.create(:weekend, user: user, week: FactoryGirl.create(:week, date: Date.new(2013,10,13)))
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.week.date)
        end
      end

      describe "follower/following counts" do
        let(:other_user) {FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end
end