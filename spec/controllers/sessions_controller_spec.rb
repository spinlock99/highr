require 'spec_helper'

describe SessionsController do
  #we need to render_views so that we can check the 
  #selectors in out html pages.
  render_views

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
  end #describe "Get 'new'"

  describe "POST 'create'" do

    describe "invalid signin" do
      
      before(:each) do
        @attr = { :email => "email@example", :password => "invalid"}
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        #new renders the session contoler's new function because 
        #we are within the scope of the SessionsController
        response.should render_template('new') 
      end

      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sign in")
      end

      it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end #describe "invalid signin"

    describe "valid email and password" do
      
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end#describe "valid email and password"
  end #describe "POST 'create'"

  describe "DELETE 'destroy'" do
    
    it "should sign a user out" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end #describe "DELETE 'destroy'"
end #describe SessionsController
