class PagesController < ApplicationController
  def home
# Devise hack
    if user_signed_in?
      redirect_to current_user
    else
      @title = "Home"
      @user = User.new
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
