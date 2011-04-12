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
end
