class Membership < ActiveRecord::Base
  # Make :team_id accessible from the web so that people
  # can join teams. do not expose member_id because we don't
  # want people to be able to maliciously place other on their teams.
  #
  # SECURITY HOLE - team membership should be mutual. We don't want
  # people signing up for teams that don't want them any more than 
  # we want teams signing up people who don't want to join.
  attr_accessible :team_id

  # Set up the relations to the User and Team models
  belongs_to :user
  belongs_to :team

  # Validations
  validates :user_id, :presence => true
  validates :team_id, :presence => true
end
