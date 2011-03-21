# == Schema Information
# Schema version: 20110321173651
#
# Table name: hvp_elements
#
#  id                       :integer         not null, primary key
#  axiological_norm         :integer
#  given_score              :integer
#  part_id                  :string(255)
#  category_id              :string(255)
#  hartman_value_profile_id :integer
#  created_at               :datetime
#  updated_at               :datetime
#

class HvpElement < ActiveRecord::Base
  attr_accessible :given_score

  belongs_to :hartman_value_profile
end
