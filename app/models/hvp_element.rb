# == Schema Information
# Schema version: 20110321173651
#
# Table name: hvp_elements
#
#  id                       :integer         not null, primary key
#  axiological_norm         :integer
#  given_value              :integer
#  part_id                  :string(255)
#  category_id              :string(255)
#  hartman_value_profile_id :integer
#  created_at               :datetime
#  updated_at               :datetime
#

class HvpElement < ActiveRecord::Base
  attr_accessible :given_value

  belongs_to :hartman_value_profile

  #validations
  validates :hartman_value_profile_id, :presence => true

  validates :axiological_norm, :presence => true
  validates_numericality_of :axiological_norm, :only_integer => true
  validates_inclusion_of :axiological_norm, :in => 1..18
                 
  validates :given_value, :presence => true
  validates_numericality_of :given_value, :only_integer => true
  validates_inclusion_of :given_value, :in => 1..18

  validates :part_id, :presence => true
  validates_inclusion_of :part_id, :in => ["self", "world"]

  validates :category_id, :presence => true
  validates_inclusion_of :category_id, 
                   :in => ["intrinsic", "extrinsic", "systemic"]
end
