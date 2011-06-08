require 'spec_helper'

describe InvitationsController do
  # render views so that we can examine the resulting html
  render_views

  describe "GET 'new'" do
    
    describe "success" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = Factory(:user)
        @team = Factory(:team)
        @user.join!(@team)
        @team = Factory(:team)
        @user.join!(@team)
        sign_in @user
      end
      
      it "should be successful" do
        get 'new'
        response.should be_success
      end
      
      it "should show the inviter's teams" do
        @teams = @user.teams
        get 'new'
        @teams.each do |team|
          response.should have_selector("body", 
                                        :content => team.name)
        end
      end
    end # success
  end # GET 'new'

  describe "POST 'create'" do
    
    describe "success" do

      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = Factory(:user)
        sign_in @user
      end

      it "should create a new user" do
        lambda do
          post :create, :user => {:email => "testing@test.com"}
        end.should change(User, :count).by(1)
      end

      it "should add new user to the right teams" do
        @team1 = Factory(:team)
        @team2 = Factory(:team)
        lambda do
          post :create, :user => { :email => "testing@test.com" }, :team => ["1", "2"]
        end.should change(Membership, :count).by(2)
      end
    end #success

    describe "failure" do

      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = Factory(:user)
      end

      it "should redirect to the login page" do
        post :create, :user => @user
        response.should redirect_to(new_user_session_path)
      end

      it "should not create a new user" do
        lambda do
          post :create, :user => @user
        end.should_not change(User, :count)
      end
    end #failure
  end # POST 'create'
end
