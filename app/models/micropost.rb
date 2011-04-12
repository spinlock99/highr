# == Schema Information
# Schema version: 20110313044020
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  # Only :content should be accessible through the web. 
  attr_accessible :content, :team_id

  # Set up the association to the User model.
  belongs_to :user
#  belongs_to :team

  # Validations
  validates :content, :presence => true
  validates :user_id, :presence => true

  # Return microposts in the reverse order that they were created
  default_scope :order => 'microposts.created_at DESC'
end
