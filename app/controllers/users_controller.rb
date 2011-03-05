class UsersController < ApplicationController

  #controller corresponding to app/views/users/show.html.erb
  #GET requests are automatically handled by the show action in rails
  def show
    #define @user as the user record with :id = the value which was passed in 
    #on the browser (i.e. /users/1 will return the user with :id = 1)
    @user = User.find(params[:id])
  end

  def new
    @title = "Sign up"
  end

  def login
    @title = "Sign in"
  end
end
