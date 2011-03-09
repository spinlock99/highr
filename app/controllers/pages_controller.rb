class PagesController < ApplicationController
  def home
    if signed_in?
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
