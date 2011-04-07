require 'spec_helper'

describe "FriendlyForwardings" do


  it "should forward to the requested page after signin" do
    user = Factory(:user)
    user.save!
    visit edit_user_path(user)
    # The test automatically follws the redirect to the signin page.
    integration_sign_in user
    # The test follows the redirect again, this time to the users/edit.
#    response.should render_template('users/edit')
    page.should have_selector('title', :content => "Edit user")
  end
end # describe "FriendlyForwardings"
