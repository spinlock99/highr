class AuthenticationsController < ApplicationController

  #
  # index 
  #
  # allows the user to view and change the different methods
  # for authenticating to highr
  def index
    @authentications = current_user.authentications if current_user
  end

  #
  # create
  #
  # Authenticate a returning user or create a new authentication
  # for an existing user
  def create
    # Store authentication hash from 3rd party web service 
    omniauth = request.env['omniauth.auth']
    logger.debug "\n\n\t omniauth \n\n"
    logger.debug omniauth

    
    # Attempt to find an existing authentication in the database
    authentication = Authentication.
      find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    
    # handle returning user, new authentication for existing user, 
    # or new user cases
    if authentication
      # we found an authentication in the database so
      # we know this is a returning user
      flash[:notice] = "Signed in successfully"
      # redirect to user's profile
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      # We did not find a matching authentication in the 
      # database but current_user is defined. This tells
      # us that a currently logged in user is adding a new
      # authentication method to their existing account.

      # build new authentication for current_user
      current_user.build_authentication(omniauth)

      flash[:notice] = "Authentication successful"
      # redirect to the page for managing authentications
      redirect_to authentications_url
    else
      # We did not find a matching authentication and there
      # is no current_user. So, we need to create a new User
      # and a new Authentication.

      # Find the invited user by the invitation_token
      user = User.accept_invitation!(:invitation_token => session[:invitation_token])

      # Build a new authentication
      user.build_authentication(omniauth)
      
      # try to save the user
      if user.save
        # if we pass the authentications redirect the new user
        # to the user's profile page
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        # if we did not pass the authentications (e.g. the new
        # user did not have an email address) we redirect to 
        # the new_user_registration_url so that the new user
        # can give us the information that we need. This is where
        # we collect emails from people who sign up with LinkedIn or 
        # Facebook.
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  #
  # destroy
  #
  # Remove an authentication mechanism from the user's account.
  #
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, 
      :notice => "Successfully destroyed authentication."
  end
end
