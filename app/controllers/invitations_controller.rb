class InvitationsController < Devise::InvitationsController
  include Devise::Controllers::InternalHelpers

  #
  # skip before filters so that we don't have to be signed in
  # to access 'users/invitation/new'
  #
  skip_filter :authenticate_inviter!
  skip_filter :authenticate!

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


# Some old bullshit left over from supporting teams

  #
  # new
  # 
  # Set up a new Invitation through Devise. This function
  # inherits from Devise::InvitationsController#new and 
  # extends it's functionallity to allow the current_inviter
  # to select teams that he wants to add the invitee to join.
  #  def new
  # store the teams that the current_inviter is a member of
  # so that the new user can be added to them.
  #    @teams = current_inviter.teams
  #    logger.debug "\n\n\t Thing \n\n"
  # call Devise::InvitationsController#new
  #    super
  #  end
  
  #
  # create
  # 
  # Create and send an Invitation through Devise. This function
  # inherits from Devise::InvitationContrller#create and extends
  # it's functionality by adding the invitee to the given teams
  #  def create
  #    logger.debug "\n\n\t Create \n\n "
  # if there is an error, the super class will render new.html.erb
  # again and show the error message. So, we need to make sure
  # that @teams is initialized so that new.html.erb can be 
  # rendered correctly.
  #    @teams = current_inviter.teams
  # Call create in the super class. This will instantiate "resource"
  # which will be the newly created user if it was successfully 
  # created. If not, resource.errors will not be empty.
  #    super
  # now add the new user to the given teams
  #    if resource.errors.empty? && params[:team]
  #      params[:team].each do |team_id|
  #        team = Team.find(team_id)
  #        resource.join!(team)
  #      end
  #    end
  #  end
  
