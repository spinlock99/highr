require 'spec_helper'

describe Membership do

  before(:each) do
    @user = Factory(:user)
    @team = Factory(:team)

    @membership = @user.memberships.build(:team_id => @team.id)
  end

  it "should create a new instance given valid attributes" do
    @membership.save!
  end

  describe "membership methods" do

    before(:each) do
      @membership.save
    end

    it "should have a user attribute" do
      @membership.should respond_to(:user)
    end

    it "should have the right user" do
      @membership.user.should == @user
    end

    it "should have a team attribute" do
      @membership.should respond_to(:team)
    end

    it "should have the right team" do
      @membership.team.should == @team
    end
  end # membership methods

  describe "validations" do
    
    it "should require a user_id" do
      @membership.user_id = nil
      @membership.should_not be_valid
    end

    it "should require a team_id" do
      @membership.team_id = nil
      @membership.should_not be_valid
    end
  end # validations
end
