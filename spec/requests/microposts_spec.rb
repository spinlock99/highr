require 'spec_helper'

describe "Microposts" do

  before(:each) do
    @user = Factory(:user)
    @team = Factory(:team)
    @user.save!
    integration_sign_in @user
    @user.join!(@team)
  end

  describe "creation" do

    describe "failure" do
      
      it "should not make a new micropost" do
        lambda do
          visit team_path(@team)
          fill_in "micropost_content", :with => ""
          click_button "Submit"
        end.should_not change(Micropost, :count)
      end

    end # failure

    describe "success" do

      it "should make a new micropost" do
        content = "Mr. T says: sucka"
        lambda do
          visit team_path(@team)
          fill_in "micropost_content", :with => content
          click_button "Submit"
          page.should have_content("Micropost created")
        end.should change(Micropost, :count).by(1)
      end
    end # success
  end # creation
end
