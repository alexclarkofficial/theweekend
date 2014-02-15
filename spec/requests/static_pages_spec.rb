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
      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) {FactoryGirl.create(:user) }
      let(:week1) { FactoryGirl.create(:week)}
      let(:week2) { FactoryGirl.create(:week, date: Date.new(2013,10,26))}
      let!(:w1) { FactoryGirl.create(:weekend, user: user, week_id: week1.id) }
      let!(:w2) { FactoryGirl.create(:weekend, user: user, week_id: week2.id) }
      let!(:image1) { FactoryGirl.create(:image, weekend_id: w1.id) }
      let!(:image2) { FactoryGirl.create(:image, weekend_id: w2.id) }
      before do
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_content(item.week.date)
        end
      end

      describe "follower/following counts" do
        before do
          other_user.follow!(user)
          visit root_path
        end

        # it { should have_link("0 following", href: following_user_path(user)) }
        # it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end
end