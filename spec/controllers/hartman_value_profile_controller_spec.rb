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
      @user.save!
      sign_in @user
#      @hvp = @user.hartman_value_profiles.create! do |hvp|
#        hvp.taken_at = DateTime.now
#      end
      @hvp = Factory(:hartman_value_profile, :user => @user)
      @hvp_element = Factory(:hvp_element, :hartman_value_profile => @hvp)
      # save the hvp so that the phrases will show up in our tests.
      @hvp.save!
      session[:hvp_id] = @hvp.id
    end

    it "should be successful"   do
      get 'get_part1', :id => @hvp
      response.should be_success
    end

    it "should have the right title" do
      get 'get_part1', :id => @hvp
      response.should have_selector("title",
                                    :content => "Part 1")
    end

    it "should have a flash message" do
      post :create
      flash[:success].should =~ /Part 1/i
    end

    describe "should have the following 18 phrases: " do
      
      it "A good meal" #do                
#        get 'get_part1', :id => @hvp
#        response.should have_selector("body",
#                                      :content => "A good meal")
#      end

      it "A technical improvement" #do
#        get 'get_part1', :id => @hvp
#        response.should have_selector("form",
#                                      :content => "A technical improvement")
#      end

      it "Nonsese"
      
      it "A fine"

      it "A rubbish heap"

      it "A devoted scientist"

      it "Blow up an airliner in flight"

      it "Burn a witch at the stake"

      it "A short circuit"

      it '"With this ring I thee wed."'

      it "A baby"

      it "Torture a person in a concentration camp"

      it "Love of Nature"

      it "A madman"

      it "An assembly line"

      it "Slavery"

      it "A mathematical genius"

      it "A uniform"
    end # 18 phrases
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

    it "should have the right title" do
      get 'get_part2', :id => @hvp
      response.should have_selector("title",
                                    :content => "Part 2")
    end

    it "should have 18 phrases"
  end # "GET 'get_part2'"
end
