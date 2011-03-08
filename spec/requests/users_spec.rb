# Integration tests for the user controler

require 'spec_helper'

describe "Users" do

  describe "signup" do
    
    describe "failure" do

      it "should not make a new user" do
        lambda do
          #visit the home page
          visit root_path
          #fill in bad info in the fields
          within "#sign_up" do
            fill_in "user[name]", :with => ""
            fill_in "user[email]", :with => ""
            fill_in "user[password]", :with => ""
            fill_in "user[password_confirmation]", :with => ""
            #push the button
            click_button
          end
          #validate response
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
   
      it "should not make a new user" do
        lambda do
          #visit the signup page
          visit signup_path
          #fill in bad info in the fields
          fill_in "Name", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          #push the button
          click_button
          #validate response
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do

      it "should make a new user on homepage" do
        lambda do
          #go to the home page 
          visit root_path
          #fill in good data in the form
          within '#sign_up' do
            fill_in "user[name]", :with => "Example User"
            fill_in "user[email]", :with => "user@example.com"
            fill_in "user[password]", :with => "foobar"
            fill_in "user[password_confirmation]", :with => "foobar"
            #push the button
            click_button
          end
          #check the response
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
          response.should render_template('users/show')
          #now make sure that we have incremented the number of users
          #in the database.
          end.should change(User, :count).by(1)
      end

      it "should make a new user" do
        lambda do
          #go to the signup page
          visit signup_path
          #fill in good data in the form
          fill_in "Name", :with => "Example User"
          fill_in "Email", :with => "user@example.com"
          fill_in "Password", :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          #push the button
          click_button
          #check the response
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
          response.should render_template('users/show')
        #now make sure that we have incremented the number of users
        #in the database.  
        end.should change(User, :count).by(1)
      end
    end
  end
end
