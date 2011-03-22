# == Schema Information
# Schema version: 20110321232428
#
# Table name: hvp_masters
#
#  id               :integer         not null, primary key
#  axiological_norm :integer
#  part_id          :string(255)
#  category_id      :string(255)
#  phrase           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class HvpMaster < ActiveRecord::Base
  attr_accessible
end
