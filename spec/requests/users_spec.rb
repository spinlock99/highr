# Integration tests for the user controler

require 'spec_helper'
require 'capybara/rails'

describe "Users" do

  describe "signup" do
    
    describe "failure" do

      it "should not make a new user" do
        lambda do
          #visit the sign up page
          visit new_user_registration_path
          #fill in bad info in the fields
          fill_in :email, :with => ""
          fill_in :password, :with => ""
          fill_in :password_confirmation, :with => ""
          #push the button
          click_button "Sign up"
          #validate response
        end.should_not change(User, :count)
      end
   
      it "should not make a new user" do
        lambda do
          #visit the signup page
          visit new_user_path
          #fill in bad info in the fields
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          #push the button
          click_button "Sign Up"
          #validate response
        end.should_not change(User, :count)
      end
    end # describe "failure"

    describe "success" do

      it "should make a new user" do
        lambda do
          #go to the signup page
          visit new_user_path
          #fill in good data in the form
          fill_in "Email", :with => "user@example.com"
          fill_in "Password", :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          #push the button
          click_button "Sign Up"
          #check the response
          page.has_selector?('title', :text => 'Home').should be_true
        #now make sure that we have incremented the number of users
        #in the database.  
        end.should change(User, :count).by(1)
      end
    end # describe "success"
  end # describe "signup"

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit new_user_session_path
        fill_in :email, :with => ""
        fill_in :password, :with => ""
        click_button "Sign in"
        page.should have_selector("div.flash.alert", :content => "Invalid")
      end
    end #describe "failure"

    describe "success" do
      it "should sign a user in and out" do
        # create a user to sign in and out
        user = Factory.create(:user)
        user.save!
        # now go to the sign in page
        visit new_user_session_path
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Sign in"
        # check that we get the page we expect for a signed in user
        page.has_selector?('title', :text => 'Home').should be_true
        page.should have_content("Signed in successfully")
        # sign out
        click_link "Sign out"
        # check the flash message to see that we've signed out
        page.should have_content("Signed out")
      end
    end # describe "success"
  end # describe "sign in/out"
end # describe "Users"
