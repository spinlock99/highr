class PagesController < ApplicationController
  def home
    @title = "Home"
    @homepage = true
    @user = User.new
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
