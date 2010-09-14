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
end
