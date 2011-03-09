class UsersController < ApplicationController
  # tell the controller to run the authenticate method before 
  # executing the edit or update functions.
  before_filter :authenticate, :only => [:edit, :update, :index]
  
  # tell the controller to run the correct_user method before
  # executing the edit or update functions.
  before_filter :correct_user, :only => [:edit, :update]

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

  # allow the signed in user to edit their information
  def edit
    @title = "Edit user"
  end

  # show all users to a signed in user
  def index
    @title = "All users"
    # create a Collection of @users with the paginate method from the 
    # will_paginate gem. The :page pramater is automatically generated
    # by will_paginate.
    @users = User.paginate(:page => params[:page],
                           :order => "updated_at DESC")
  end

  # show a user page to another signed in user
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  # update the signed in user
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  # begin private methods
  private

  # authenticate the user by ensuring that it is signed in
  def authenticate
    deny_access unless signed_in?
  end

  # make sure that the current_user has the same id as
  # the user that we are trying to edit.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
