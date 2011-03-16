module UserSessionsHelper
  # Authlogic hacks
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to current_user
      return false
    end
  end

  def require_user
    deny_access unless signed_in?
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  # make sure that the current_user has the same id as
  # the user that we are trying to edit.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end


  # end Authlogic hacks

#  def sign_in(user)
    # create a cookie that will expire in 20 years.
    # :remember_token is a secure token associated with the 
    # User model that we use instead of the user.id to 
    # avoid spoofing. Sign the :remember_token with the user.salt
    # to harden against malicious attack.
#    cookies.permanent.signed[:remember_token] = [user.id, user.password_salt]
#    self.current_user = user
#  end

  # define helper function to handle the assignment of 
  # the variable 'user' to instance variable '@current_user'
  # This looks like pointers in C and I'm sure there's something
  # deeper going on here than is apparent at first blush.
  def current_user=(user)
    @current_user = user
  end
#
#  def current_user
    # we need this so that @current_user persists across pages.
    # the 'or equals' operator sets 
    # @current_user = @currenet_user || user_from_remember_token
    # where the or operator is evaluated left to right and returns
    # the first true value (i.e. @current_user if it is defined or 
    # user_from_remember_token if @current_user == nil).
#    @current_user ||= user_from_remember_token
#  end

  # method to test if the given user is the current_user 
  # (i.e. the user that is signed in).
  def current_user?(user)
    user == current_user
  end

  # method to deny access to a user
  def deny_access
    # make a note of the page we were on for friendly forwarding
    store_location
    # send the user to the sign_in page
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  # method to redirect the user back to the failed page or to a default page
  def redirect_back_or(default)
    # or is evaluated left to right so redirect_to will take the first
    # argument that evaluates to true.
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  # check for a signed in user. returns true if current_user is not nil.
  def signed_in?
    !current_user.nil?
  end

  # sign_out the current user
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  # begin private functions
  private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  # we need to define remember_token because Rails tests for 
  # signed cookies are still rather immature.
  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end

  # private method to put the fullpath of the current request into
  # the session variable.
  def store_location
    session[:return_to] = request.fullpath
  end
  
  # private method to clear the session variable of the :return_to
  # data
  def clear_return_to
    session[:return_to] = nil
  end
end
