class MicropostsController < ApplicationController
  # Ensure that only logged in users can access micropost controlers.
  before_filter :authenticate_user!
  before_filter :authorized_user, :only => :destroy

  #
  # create
  #
  # Create a new micropost for the current_user. Redirect to the root_path
  # on success and 'pages/home' on failure.
  #
  def create
    logger.debug "\n\n\t params[:micropost] \n"
    logger.debug params[:micropost]
    logger.debug "\n\n\t current_user \n"
    logger.debug current_user
#    logger.debug "\n\n\t current_team \n"
#    logger.debug current_user.current_team
    # build micropost from passed in parameters
    @micropost = current_user.microposts.build(params[:micropost])
    # save the micropost
    if @micropost.save
      # redirect back on success
      flash[:success] = "Micropost created!"
      redirect_back_or root_path
    else
      # set @user = current_user so that our views work correctly.
      @user = current_user
      # redirect to 'pages/home' on failure
      @team_talk_items = []
      render 'pages/home'
    end
  end

  #
  # destroy
  #
  # Allow a user to delete their _own_ microposts
  #
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

private

  #
  # authorized_user
  #
  # Make sure that the current user is the owner of the micropost. Redirect
  # to root path if they are not.
  #
  def authorized_user
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless current_user == @micropost.user
  end
end
