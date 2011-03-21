# == Schema Information
# Schema version: 20110321173651
#
# Table name: hartman_value_profiles
#
#  id         :integer         not null, primary key
#  taken_at   :datetime
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class HartmanValueProfile < ActiveRecord::Base
  # none of the elements of this model should be editable from the web
  attr_accessible

  # set-up user and hvp_elements associations
  belongs_to :user
  has_many :hvp_elements

  # validations
  validates :taken_at, :presence => true
  validates :user_id, :presence => true

  # order the tests to that the newest is displayed first
  default_scope :order => 'hartman_value_profiles.taken_at DESC'
end
