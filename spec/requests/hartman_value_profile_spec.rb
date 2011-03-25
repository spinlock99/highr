# Integration tests for the Hartman Value Profile

require 'spec_helper'

describe "HartmanValueProfiles" do

  describe "take the assesment" do
    
    describe "failure" do

    end # failure

    describe "success", :type => :request do

#      before(:each) do
#        @user = Factory(:user)
#        integration_sign_in @user
#        visit signup_path
#        fill_in :username, :with => @user.username
#        fill_in :password, :with => @user.password
#        click_button 'Login'
#      end

      it "should create a new hartman_value_profile" 
#      do
#        lambda do
#          @user = Factory(:user)
#          visit signup_path
#          fill_in :username, :with => @user.username
#          fill_in :email,    :with => @user.email
#          fill_in :password, :with => @user.password
#          fill_in :password_confirmation, :with => @user.password
#          fill_in :username, :with => "Testor"
#          fill_in :email,    :with => "testor@test.com"
#          fill_in :password, :with => "testing"
#          fill_in :password_confirmation, :with => "testing"
#          click_button 'Sign Up'
#          page.should have_selector("a", 
#                                 :content => "Hartman Value Profile")
          #vist the page for a new Hartman Value Profile
          
#          visit new_hartman_value_profile_path
          # click the button
#          click_button 'Continue'
          # validate the response
#          response.should have_selector("div.flash.success",
#                                        :content => "Part 1")
          # fill in part1
#          within "#edit_hartman_value_profile_#{@user.id}" do
#            fill_in "#hartman_value_profile_hvp_elements_attributes_2_given_value", :with => "1"
#            fill_in "hartman_value_profile[hvp_elements_attributes][2][given_value]", :with => "1"
            # click the button
#            click_button 'Continue'
#          end
#          response.should have_selector("div.flash.success",
#                                        :content => "Part 2")
          # fill in part2
          # click the button
          # now make sure that we've incremented the number of 
          # hartman_value_profiles and hvp_elementsin the database
#        end.should change(HartmanValueProfile, :count).by(1)
#      end
    end
  end # take the assesment
end # HartmanValueProfiles
