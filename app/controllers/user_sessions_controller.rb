class UserSessionsController < ApplicationController

  # GET /user_sessions/new
  def new
    @user_session = UserSession.new

    render @user_session
  end

  # POST /user_sessions
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to :users, :notice => 'Login Successful'
    else
      render :action => "new"
    end
  end

  # DELETE /user_sessions/1
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    redirect_to :root, :notice => 'Goodbye!'
  end
end
