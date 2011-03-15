class UserSessionsController < ApplicationController

  # GET /user_sessions/new
  def new
    @title = "Sign in"
    @user_session = UserSession.new

    render 'new'
  end

  # POST /user_sessions
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      redirect_back_or @user_session.user
    else
      flash.now[:error] = "Invalid username/password combination."
      @title = "Sign in"
      render 'new'
    end
  end

  # DELETE /user_sessions/1
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    redirect_to :root, :notice => 'Goodbye!'
  end
end
