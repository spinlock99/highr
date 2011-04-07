# Integration tests for the user controler

require 'spec_helper'
require 'capybara/rails'

describe "Users" do

  describe "signup" do
    
    describe "failure" do

      it "should not make a new user" do
        lambda do
          #visit the home page
          visit root_path
          #fill in bad info in the fields
          within "#sign_up" do
            fill_in "user[email]", :with => ""
            fill_in "user[password]", :with => ""
            fill_in "user[password_confirmation]", :with => ""
            #push the button
            click_button "Sign Up"
          end
          #validate response
#          response.should render_template('registrations/new')
#          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
   
      it "should not make a new user" do
        lambda do
          #visit the signup page
          visit new_user_path
          #fill in bad info in the fields
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
#          fill_in "user_password_confirmation]", :with => ""
          fill_in "Confirmation", :with => ""
          #push the button
          click_button "Sign Up"
          #validate response
 #         response.should render_template('users/new')
 #         response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end # describe "failure"

    describe "success" do

#      it "should make a new user on homepage" do
#        lambda do
#          #go to the home page 
#          visit root_path
#          #fill in good data in the form
#          within '#sign_up' do
#            fill_in "user[username]", :with => "Example User"
#            fill_in "user[email]", :with => "user@example.com"
#            fill_in "user[password]", :with => "foobar"
#            fill_in "user[password_confirmation]", :with => "foobar"
#            #push the button
#            click_button
#          end
#          #check the response
#          response.should have_selector("div.flash.success",
#                                        :content => "Welcome")
#          response.should render_template('users/show')
#          #now make sure that we have incremented the number of users
#          #in the database.
#          end.should change(User, :count).by(1)
#      end

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
#          save_and_open_page
          #check the response
          page.has_selector?('title', :text => 'Home').should be_true
#          response.should have_selector("div.flash.success",
#                                        :content => "Welcome")
#          response.should render_template('pages/home')
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
#        response.should have_selector("div.flash.alert", :content => "Invalid")
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
