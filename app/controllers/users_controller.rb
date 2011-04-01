class UsersController < ApplicationController
  # tell the controller to run the require_no_user method before
  # executing the new or create methods
# Devise Hack
#  before_filter :require_no_user, :only => [:new, :create]
  
  # tell the controller to run the :require_user method before
  # the show, and index functions
# Devise Hack
#  before_filter :require_user, :only => [:edit, :update, :index, 
#                                         :show, :destroy]
  
  # make sure we have the correct user before allowing an edit or update
# Devise Hack
#  before_filter :correct_user, :only => [:edit, :update]

  # restrict destroy to admins only
# Devise Hack
#  before_filter :admin_user, :only => :destroy

  # Devise 
  before_filter :authenticate_user!, :only => [:edit, :update, :index,
                                               :show, :destroy]

  def new
    # redirect a signed in user to their home page
    if current_user
      redirect_to root_path
    end
    @title = "Sign up"
    @user = User.new
  end
  
  # create a new user. The C in CRUD and the POST in html.
  def create
    # redirect a signed in user to their home page
    if current_user
      redirect_to root_path
    end
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to highr"
      redirect_to @user
    else
      @title = "Sign up"
      render :action => :new
    end
  end
  
  def show
    @user = current_user
# Devise Hack
#    @title = @user.username
  end

  def edit
    @title = "Edit user"
    @user = current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
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

  # remove the specified user from the system
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  # begin private methods
  private
  
  # redirect to the home page unless the current user is an admin
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
