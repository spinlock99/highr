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
  attr_accessible

  belongs_to :user
  has_many :hvp_elements

  default_scope :order => 'hartman_value_profiles.taken_at DESC'
end
