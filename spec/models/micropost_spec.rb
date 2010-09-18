require 'spec_helper'

describe Micropost do
  describe "invalid user" do
    @attr = {
      :content => "value for content",
      :user_id => 1
    }
    micropost = Micropost.new @attr
    micropost.user_id.should == nil
  end

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create! @attr
  end

  it "should have a content given content" do
    micropost = @user.microposts.create @attr
    micropost.content.should == "value for content"
  end

  describe "user associations" do
    before(:each) do
      @micropost = @user.microposts.create @attr
    end

    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end


  describe "validations" do
    it "should require a user id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.microposts.build(:content => "   ").should_not be_valid
    end

    it "should reject long content" do
      @user.microposts.build(:content => "a" * 141).should_not be_valid
    end
  end


  describe "from_users_followed_by" do
    it "should include the followed user's microposts" do
      other_user = Factory(:user, :email => Factory.next(:email))
      other_post = other_user.microposts.create!(:content => "foo")
      @user.follow! other_user
      Micropost.from_users_followed_by(@user).
        include?(other_post).should be_true
    end

    it "should include the user's own microposts" do
      user_post = @user.microposts.create!(:content => "foo")
      Micropost.from_users_followed_by(@user).
        include?(user_post).should be_true
    end

    it "should not include an unfollowed user's microposts" do
      third_user = Factory(:user, :email => Factory.next(:email))
      third_post = third_user.microposts.create!(:content => "foo")
      Micropost.from_users_followed_by(@user).
        include?(third_post).should be_false
    end
  end
end
