require 'spec_helper'

describe Vote do

  let (:user) { FactoryGirl.create(:user) }
  let (:other_user) { FactoryGirl.create(:user) }
  let (:week) { FactoryGirl.create(:week) }
  let (:weekend) { FactoryGirl.create(:weekend, user: user, week_id: week.id) }
  before { @vote = other_user.votes.build(weekend_id: weekend.id) }

  subject { @vote }

  it { should respond_to(:weekend_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:weekend) }
  it { should respond_to(:user) }
  its(:user) { should eq(other_user) }
  its(:weekend) { should eq(weekend) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @vote.user_id = nil }
    it { should_not be_valid }
  end

  it "does not duplicate votes" do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:vote, user_id: user.id, weekend_id: weekend.id)
    FactoryGirl.build(:vote, user_id: user.id, weekend_id: weekend.id).should_not be_valid
  end
end
