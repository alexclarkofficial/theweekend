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
end