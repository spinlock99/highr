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
  end

  it "should have a signin page at '/users/sign_in'" do
    get '/users/sign_in'
    response.should have_selector('h2', :content => "Sign in")
  end

  it "should have the right links on the layout" do
    user = Factory.create(:user)
    user.save!
#    visit new_user_session_path
#    fill_in "Email", :with => user.email
#    fill_in "Password", :with => user.password
#    click_button "Sign in"
    integration_sign_in user
    visit root_path
    click_link "About"
    page.has_selector?('title', :text => 'About')
    click_link "Help"
    page.has_selector?('title', :text => 'Help')
    click_link "Contact"
    page.has_selector?('title', :text => 'Contact')
    click_link "Home"
    page.has_selector?('title', :text => 'Home')
    click_link "Sign out"
    page.should have_content("Signed out successfully.")
  end

  describe "when signed in" do
    
    before(:each) do
      @user = Factory(:user)
      @user.save!
      integration_sign_in @user
    end

    it "should have a signout link" do
      visit root_path
      page.should have_selector("a", :href => destroy_user_session_path,
                                    :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      page.should have_selector("a", :href => user_path(@user),
                                    :content => "Profile")
    end
    it "should have a HVP link" do
      visit root_path
      click_link "Profile"
      page.should have_selector("a", 
                          :href => new_hartman_value_profile_path,
                          :content => "Hartman Value Profile")
    end
  end # describe "when signed in"
end # describe "Layout links"
