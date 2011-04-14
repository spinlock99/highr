class TeamsController < ApplicationController

  #
  # new
  #
  # Show the user a for to make a new team
  #
  def new
    @title = "Create a Team"
    @team = Team.new
  end
  
  #
  # create
  #
  # Create a new team from the fields passed in from the new form.
  #
  def create
    @team = Team.new(params[:team])
    if @team.save
      # the current user should join the team
      current_user.join!(@team)
      flash[:success] = "New team created"
      redirect_to @team
    else
      @title = "Create a Team"
      render :action => :new
    end
  end

  #
  # show
  #
  # Create a page for a team and show the members of the team.
  #
  def show
    @team = Team.find(params[:id])
    @members = @team.members
    @title = @team.name
    @micropost = Micropost.new
    @team_talk_items = @team.team_talk.paginate(:page => params[:page])
    @user = current_user
    # Set the current_team. Who knows if this is best practices
#    @user.current_team = @team
#    @user.save!
    session[:team_id] = @team_id
    @users = User.paginate(:page => params[:page])
  end
end
