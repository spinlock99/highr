class RegistrationsController < Devise::RegistrationsController
  
  #
  # create
  #
  # Create a new Registration through Devise. This function 
  # inherits from Devise::RegistrationsController#create and 
  # extends it's functionality
  def create
    super
    # clear information stored from omniauth unless we
    # have just created a new user in which case we will
    # keep this information in order to store useful information
    # about the new user.
    session[:omniauth] = nil unless @user.new_record?
  end

  #
  # Attempting to set a title when new user is created.
  # This is not working yet.
  def new
    super
    @title = "Sign up"
    logger.debug "\n\n\t RegistrationsController#new \n\n"
  end

  private

  #
  # build_resources(*args)
  #
  # Builds the User model inside the new and create actions of the 
  # RegistrationsController. 
  # Extends Devise::RegistrationsController#build_resources(*args)
  #
  def build_resource(*args)
    # Call the parent function to build the User model.
    super
    
    # If we have :omniauth in our session cookie we will build
    # an authentication for the new user from that and then 
    # check to make sure the user is valid (i.e. get the password
    # from someone who created an account via LinkedIn or Facebook).
    if session[:omniauth]
      @user.build_authentication(session[:omniauth])
      @user.valid?
    end
  end
end
