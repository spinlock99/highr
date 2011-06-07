class InvitationsController < Devise::InvitationsController

  #
  # new
  # 
  # Set up a new Invitation through Devise. This function
  # inherits from Devise::InvitationsController#new and 
  # extends it's functionallity to allow the current_inviter
  # to select teams that he wants to add the invitee to join.
  def new
    # store the teams that the current_inviter is a member of
    # so that the new user can be added to them.
    @teams = current_inviter.teams
    # call Devise::InvitationsController#new
    super
  end

  #
  # create
  # 
  # Create and send an Invitation through Devise. This function
  # inherits from Devise::InvitationContrller#create and extends
  # it's functionality by addint the invitee to the given teams
  def create
    # if there is an error, the super class will render new.html.erb
    # again and show the error message. So, we need to make sure
    # that @teams is initialized so that new.html.erb can be 
    # rendered correctly.
    @teams = current_inviter.teams
    # Call create in the super class. This will instantiate "resource"
    # which will be the newly created user if it was successfully 
    # created. If not, resource.errors will not be empty.
    super
    # now add the new user to the given teams
    if resource.errors.empty? && params[:team]
      params[:team].each do |team_id|
        team = Team.find(team_id)
        resource.join!(team)
      end
    end
  end
end
