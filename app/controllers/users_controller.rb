class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :index]
  
  def new
    @title = "Sign up"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to highr"
      redirect_back_or @user
    else
      @title = "Sign up"
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @title = "Edit user"
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated!"
      redirect_to @user
    else
      @title = "Edit user"
      render :action => :edit
    end
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
end
