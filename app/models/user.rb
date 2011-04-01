# == Schema Information
# Schema version: 20110321173651
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
#  oauth_token       :string(255)
#  oauth_secret      :string(255)
#

#User model is a subclass of ActiveRecord::Base 
#and inherits all of it's methods.
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, 
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Authlogic configuration
#  acts_as_authentic do |c|
#  
#    c.merge_validates_length_of_password_field_options :minimum => 6 
#    c.merge_validates_length_of_password_field_options :maximum => 40 
#    
#  end

#  validates :username, :presence => true,
#                       :length => { :maximum => 50}

  has_many :hartman_value_profiles
  has_many :authentications

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
