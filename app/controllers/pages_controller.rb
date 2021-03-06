class PagesController < ApplicationController
#  include Devise::Controllers::InternalHelpers

  def home
    @title = "Home"
    if user_signed_in?
#      redirect_to current_user
      @user = current_user
      @micropost = Micropost.new
      @team_talk_items = current_user.team_talk.paginate(
                                                 :page => params[:page])
    else
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
