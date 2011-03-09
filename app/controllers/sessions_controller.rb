class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  #create is called when we POST data to the SessionsController.
  #This can happen from the home page or the signin page
  def create
    #set the variable 'user' by calling the authenticate method 
    #on the User model. Return will be nil if no match is found in the 
    #database.
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      #we use flash.now rather than flash because flash is 
      #designed to render after a redirect and we are just rendering
      #the new page (not redirecting to it).
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      # Sign in the new user.
      sign_in user
      # redirect back to the page that failed or to user show page.
      redirect_back_or user
    end
  end

  # destroy the session in order to log out the user
  def destroy
    sign_out
    redirect_to root_path
  end
end
