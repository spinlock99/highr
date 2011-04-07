require 'spec_helper'

describe "Microposts" do

  before(:each) do
    user = Factory(:user)
    user.save!
#      visit new_user_session_path
#      fill_in "Email", :with => user.email
#      fill_in "Password", :with => user.password
#      click_button "Sign in"
#      save_and_open_page
    integration_sign_in user
  end

  describe "creation" do

    describe "failure" do
      
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in "micropost_content", :with => ""
          click_button "Submit"
        end.should_not change(Micropost, :count)
      end

    end # failure

    describe "success" do

      it "should make a new micropost" do
        content = "Mr. T says: sucka"
        lambda do
          visit root_path
          fill_in "micropost_content", :with => content
          click_button "Submit"
#          save_and_open_page
          page.should have_content("Micropost created")
        end.should change(Micropost, :count).by(1)
      end
    end # success
  end # creation
end
