require 'spec_helper'

describe Team do

  before(:each) do
    @user = Factory(:user)
    @team = Factory(:team)
  end

  it "should create a new instance given valid attributes" do
    @team = Factory.build(:team)
    @team.save!
  end

  it "should respond to members" do
    @team = Factory.build(:team)
    @team.should respond_to(:members)
  end

  it "should include the user in the members array" do
    @user.join!(@team)
    @team.members.should include(@user)
  end
end
