class PagesController < ApplicationController
#  include Devise::Controllers::InternalHelpers

  def home
    if user_signed_in?
      redirect_to current_user
    else
      @title = "Home"
      @user = User.new
#      clean_up_passwords(build_resource)
#      render_with_scope :new
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end
end
