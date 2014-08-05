require 'spec_helper'

describe User do
  
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
  	                        password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  describe "with admin set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when name is not present" do
  	before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.name = @user.name.upcase
      user_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.name = @user.name.upcase
      user_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user.password = " "
      @user.password_confirmation = " "
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
  before { @user.save }
  let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) {should_not be_blank}
  end

  describe "weekends associations" do
    before { @user.save }
    let!(:newer_weekend) do
      FactoryGirl.create(:weekend, user: @user, week_id: FactoryGirl.create(:week, date: Date.new(2013,10,26)).id)
    end
    let!(:older_weekend) do
      FactoryGirl.create(:weekend, user: @user, week_id: FactoryGirl.create(:week, date: Date.new(2013,10,19)).id)
    end

    describe "feed" do
      let!(:unfollowed_post) do
        FactoryGirl.create(:weekend, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_weekend) }
      its(:feed) { should include(older_weekend) }
      its(:feed) { should_not include(unfollowed_post) }
    end

    it "should have the right weekend in the right order" do
      #expect(@user.weekends.to_a).to eq [newer_weekend, older_weekend]
    end

    it "should destroy associated weekends" do
      weekends = @user.weekends.to_a
      @user.destroy
      expect(weekends).not_to be_empty
      weekends.each do |weekend|
        expect(Weekend.where(id: weekend.id)).to be_empty
      end
    end

    # describe "status" do
    #   let(:unfollowed_weekend) { FactoryGirl.create(:weekend, user: FactoryGirl.create(:user)) }
    #   let(:followed_user) { FactoryGirl.create(:user) }

    #   before do
    #     @user.follow!(followed_user)
    #     3.times { followed_user.weekends.create!(week_id: week.id) }
    #   end

    #   its(:feed) { should include(newer_weekend) }
    #   its(:feed) { should include(older_weekend) }
    #   its(:feed) { should_not include(unfollowed_weekend)}
    #   its(:feed) do
    #     followed_user.weekends.each do |weekend|
    #       should include(weekend)
    #     end
    #   end
    # end
  end

  describe "votes associations" do
    before do
      @user.save
      author = FactoryGirl.create(:user)
      @weekend = FactoryGirl.create(:weekend, user: author)
    end

    let!(:vote) { FactoryGirl.create(:vote, user_id: @user.id, weekend_id: @weekend.id) }

    it "should destroy votes when destroyed" do
      votes = @user.votes.to_a
      @user.destroy
      expect(votes).to_not be_empty
      votes.each do |vote|
        expect(Vote.where(id: vote.id)).to be_empty
      end
    end
  end

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end

    describe "unfollowing" do
      before { @user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end


  describe "voting" do
    let(:weekend) { FactoryGirl.create(:weekend) }
    before do
      @user.save
      @user.vote!(weekend)
    end

    it { should be_voted_for(weekend) }
    its(:voted_weekends) { should include(weekend) }

    describe "weekend" do
      subject { weekend }
      its(:voters) { should include(@user) }
    end

    describe "unvoting" do
      before { @user.unvote!(weekend) }

      it { should_not be_following(weekend) }
      its(:voted_weekends) { should_not include(weekend) }
    end
  end
end