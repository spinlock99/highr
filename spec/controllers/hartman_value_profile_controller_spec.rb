require 'spec_helper'

describe HartmanValueProfilesController do
  # render_views is neccessary to look at the resulting html.
  # (i.e. response.should have_selector ...)
  render_views

  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", 
                      :content => "New Hartman Value Profile")
    end

    
  end # "GET 'new'"
end
