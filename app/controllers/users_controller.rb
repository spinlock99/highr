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

  #create a new user. The C in CRUD and the POST in html.
  def create
    #instantiate a @user variable - what kind of variable? there's a name -
    #with all of the appropriate fields from the user model.
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to HighR!"
      redirect_to @user
    else
      @title = "Sign up"
      #blank out the password fields
      @user.password = ""
      @user.password_confirmation = ""
      #now show the new user page with errors
      render 'new'
    end
  end
end
