class TeamsController < ApplicationController
  
  #
  # show
  #
  # Create a page for a team and show the members of the team.
  #
  def show
    @team = Team.find(params[:id])
    @users = @team.members
    @title = @team.name
    @micropost = Micropost.new
    @team_talk_items = @team.team_talk.paginate(:page => params[:page])
    @user = current_user
    # Set the current_team. Who knows if this is best practices
#    @user.current_team = @team
#    @user.save!
    session[:team_id] = @team_id
  end
end
