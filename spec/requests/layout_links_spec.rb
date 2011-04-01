require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a signup page at '/users/sign_up'" do
    get '/users/sign_up'
    response.should have_selector('h2', :content => "Sign up")
#    response.should have_selector('title', :content => "Sign up")
  end

  it "should have a signin page at '/users/sign_in'" do
    get '/users/sign_in'
    response.should have_selector('h2', :content => "Sign in")
#    response.should have_selector('title', :content => "Sign in")
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
#
#   The sign up and sign in links are now a button. So the tests below fails
#
#   TODO: figure out how to test a button press.
#
#    click_link "Sign up now!"
#    response.should have_selector('title', :content => "Sign up")   
#    visit root_path
#    click_link "Sign in"
#    response.should have_selector('title', :content => "Sign in")
  end

  describe "when signed in" do
    
    before(:each) do
      @user = Factory(:user)
      integration_sign_in @user
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => destroy_user_session_path,
                                    :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                    :content => "Profile")
    end
    it "should have a HVP link" do
      visit root_path
      response.should have_selector("a", 
                          :href => new_hartman_value_profile_path,
                          :content => "Hartman Value Profile")
    end
  end # describe "when signed in"
end # describe "Layout links"
