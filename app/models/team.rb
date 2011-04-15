class Team < ActiveRecord::Base
  has_many :memberships
  has_many :members, :through => :memberships, :source => :user

  has_one :relevant_user, :class_name => 'User', 
          :foreign_key => 'current_team_id'
  #
  # team_talk
  #
  # List of all microposts that are associated with this team.
  def team_talk
    Micropost.where("team_id = ?", id)
  end

  #
  # invite
  #
  # allows one user to invite another user to join their team.
  #
  def invite(current_user, user)
    # create a micropost so that the team can see that a new member has
    # been invited to join.
    @micropost = current_user.microposts.create(:team_id => self.id,
                     :content => "invited #{user.name} to join #{self.name}")
    @micropost.save!
    # now, create an invitation that the new member can accept
    
  end
end
