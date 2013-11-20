require 'spec_helper'

describe Week do
  before do
    @week = Week.create(date: Date.new(2013,11,01))
  end
  let (:user1) {FactoryGirl.create(:user) }
  let (:user2) {FactoryGirl.create(:user) }
  let (:weekend1) {FactoryGirl.create(:weekend, user: user1, week: @week)}
  let (:weekend2) {FactoryGirl.create(:weekend, user: user2, week: @week)}
  let (:weekend3) {FactoryGirl.create(:weekend)}

  subject { @week }

  it { should respond_to(:date) }
  it { should respond_to(:weekends) }
  
end