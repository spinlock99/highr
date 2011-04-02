require 'spec_helper'

describe HartmanValueProfilesController do
  # render_views is neccessary to look at the resulting html.
  # (i.e. response.should have_selector ...)
  render_views

  #
  # Test that a non-signed-in user can't take the HVP
  #
  describe "access control" do 

    before(:each) do
      # create a user but don't sign him in
      @user = Factory.create(:user)
      @hvp = @user.hartman_value_profiles.create
    end # before(:each) do

    it "should deny access to 'new'" do
      get :new
      response.should redirect_to(new_user_session_path)
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(new_user_session_path)
    end

    it "should deny access to 'get_part1'" do
      get :get_part1, :id => 1
      response.should redirect_to(new_user_session_path)
    end
    
    it "should deny access to 'put_part1'" do
      put :put_part1, :id => 1
      response.should redirect_to(new_user_session_path)
    end
    
    it "should deny access to 'get_part2'" do
      get :get_part2, :id => 1
      response.should redirect_to(new_user_session_path)
    end
    
    it "should deny access to 'put_part2'" do
      put :put_part2, :id => 1
      response.should redirect_to(new_user_session_path)
    end
  end # "access control"
  
  describe "GET 'new'" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
    end
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", 
                                    :content => "New Hartman Value Profile")
    end
  end # "GET 'new'"

  describe "GET 'get_part1'" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
      @hvp = @user.hartman_value_profiles.create! do |hvp|
        hvp.taken_at = DateTime.now
      end
      session[:hvp_id] = @hvp.id
    end

    it "should be successful"   do
      get 'get_part1', :id => @hvp
      response.should be_success
    end

    it "should have the right title" 

    it "should have 18 phrases"
  end # "GET 'get_part1'"

  describe "GET 'get_part2'" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
      @hvp = @user.hartman_value_profiles.create! do |hvp|
        hvp.taken_at = DateTime.now
      end
      session[:hvp_id] = @hvp.id
    end

    it "should be successful" do
      get 'get_part2', :id => @hvp
      response.should be_success
    end

    it "should have the right title"

    it "should have 18 phrases"
  end # "GET 'get_part2'"
end
