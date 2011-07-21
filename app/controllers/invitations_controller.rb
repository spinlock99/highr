class InvitationsController < Devise::InvitationsController
  include Devise::Controllers::InternalHelpers

  #
  # skip before filters so that we don't have to be signed in
  # to access 'users/invitation/new'
  #
  skip_filter :authenticate_inviter!
  skip_filter :authenticate!

  respond_to :html, :js

  #
  # edit
  #
  # extend base-class to store the invitation token in the session
  # cookie so that we can find it after authenticating with a 3rd 
  # party service
  #
  def edit
    if params[:invitation_token]
      session[:invitation_token] = params[:invitation_token]
    end
    super
  end
  
  protected
  
  #
  # current_inviter
  #
  # over-ride current_inviter so that it will create a user
  # from the passed in params if the user is not signed in rather
  # than redirect to the devise authentications page.
  #
  def current_inviter
    if user_signed_in?
      super
    else
      @current_inviter ||= User.new(params[:user])
    end
  end

end
