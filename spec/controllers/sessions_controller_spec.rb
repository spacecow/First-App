require 'spec_helper'

describe SessionsController do
  render_views
  describe "GET 'new'" do
    before(:each) do
      get :new
    end

    it "should be successful" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "Sign in")
    end
  end


  describe "POST 'create'" do
    describe "invalid signin" do
      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
        post :create, :session => @attr
      end

      it "should re-render the new page" do
        response.should render_template(:new)
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "Sign in")
      end

      it "should have a flash.now message" do
        flash.now[:error].should =~ /invalid/i
      end
    end


    describe "with valid email and password" do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
        post :create, :session => @attr
      end

      it "should sign the user in" do
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the user show page" do
        response.should redirect_to(user_path(@user))
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should sign a user out" do
      test_sign_in(Factory(:user))
      controller.should be_signed_in
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
end
