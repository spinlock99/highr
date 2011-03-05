# == Schema Information
# Schema version: 20110304165246
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

#User model is a subclass of ActiveRecord::Base 
#and inherits all of it's methods.
class User < ActiveRecord::Base
  #make name and email attributes accessible to outside users
  attr_accessible :name, :email

  #validate that the name attribute is present in the user record
  validates :name, :presence => true,
                   #validate the name is less than 51 chars
                   :length => {:maximum => 50}

  #regex matching valid emails
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #validate that the email attribute is present in the user record
  validates :email, :presence => true,
                    #validate the email format 
                    :format => { :with => email_regex },
                    #validate that the email is unique
                    :uniqueness => { :case_sensitive => false }
end
