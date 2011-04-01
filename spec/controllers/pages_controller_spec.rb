require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "HighR"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content => @base_title + " | Home")
    end

    it "should not have a header" do
      get 'home'
      response.should_not have_selector("header")
    end

    it "should have a name field" 
#do
#      get :home
#      response.should have_selector(
#                           "input[name='user[username]'][type='text']")
#    end

    it "should have an email field" do
      get :home
      response.should have_selector("input[name='user[email]'][type='text']")
    end

    it "should have a password field" do
      get :home
      response.should have_selector(
                           "input[name='user[password]'][type='password']")
    end

    it "should have a password_confirmation field" do
      get :home
      response.should have_selector(
              "input[name='user[password_confirmation]'][type='password']")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => @base_title + " | Contact")
    end
  end

  describe "Get 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content => @base_title + " | About")
    end
  end

  describe "Get 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                                    :content => @base_title + " | Help")
    end
  end
end
