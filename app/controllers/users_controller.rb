class UsersController < ApplicationController

  #controller corresponding to app/views/users/show.html.erb
  #GET requests are automatically handled by the show action in rails
  def show
    #define @user as the user record with :id = the value which was passed in 
    #on the browser (i.e. /users/1 will return the user with :id = 1)
    @user = User.find(params[:id])

    #a title for the user show page
    @title = @user.name
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def login
    @title = "Sign in"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to HighR!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
end
