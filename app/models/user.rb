# == Schema Information
# Schema version: 20110313044020
#
# Table name: users
#
#  id                :integer         not null, primary key
#  username          :string(255)
#  email             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  admin             :boolean
#  persistence_token :string(255)
#

#User model is a subclass of ActiveRecord::Base 
#and inherits all of it's methods.
class User < ActiveRecord::Base
  acts_as_authentic do |c|
  
    c.merge_validates_length_of_password_field_options :minimum => 6 
    c.merge_validates_length_of_password_field_options :maximum => 40 
    
  end
  validates :username, :presence => true,
                       :length => { :maximum => 50}

end
