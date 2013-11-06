require 'spec_helper'

describe Weekend do

  let (:user) {FactoryGirl.create(:user) }
  before { @weekend = user.weekends.build(week: Date.new(2013,10,19)) }

  subject { @weekend }

  it { should respond_to(:week) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @weekend.user_id = nil }
  	it { should_not be_valid }
  end

  describe "like associations" do
    before do
      @weekend.save
      @voter = FactoryGirl.create(:user)
    end
    let!(:vote) { FactoryGirl.create(:vote, user_id: @voter.id, weekend_id: @weekend.id) }

    it "should destroy associated votes" do
      votes = @weekend.votes.to_a
      @weekend.destroy
      expect(votes).not_to be_empty
      votes.each do |vote|
        expect(Vote.where(id: vote.id)).to be_empty
      end
    end
  end
end