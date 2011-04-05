# == Schema Information
# Schema version: 20110331210031
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
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

  # Add associations to HVP and Authentications
  has_many :hartman_value_profiles
  has_many :authentications

  # Build an Authentication record for the user based on the 
  # provider and uid information gleaned by omniauth.
  def build_authentication(omniauth)
    # now put the authentication in the database
    authentications.build(:provider => omniauth['provider'], 
                    :uid => omniauth['uid'],
                    :token => omniauth['credentials']['token'],
                    :secret => omniauth['credentials']['secret'])
    # If the provider is Linked in, get additional information
    # to build a user profile.
    if omniauth['provider'] == 'linked_in'
      self.build_linkedin(omniauth)
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

#  def linkedin
#    unless @linkedin
#      @linkedin = LinkedIn::Client.new(
#          "zpfoZeTY4UFhmGZ3s23jKbJ4ZSs4r2wwb40FwjLEuntcHdi6Tfsk19F1o1BZ1SA4", 
#          "_T1VdwWitfALil_swkRRleOJMLZ-eZyKJSEYbYOV0wF_Ml34ZvxFo-qc6S7Y_fIB")
#      @linkedin.authorize_from_access(omniauth['credentials']['token'],
#                                 omniauth['credentials']['secret'])
#    end
#    @linkedin
#  end

protected

  def build_linkedin(omniauth)
    client = LinkedIn::Client.new(
          "zpfoZeTY4UFhmGZ3s23jKbJ4ZSs4r2wwb40FwjLEuntcHdi6Tfsk19F1o1BZ1SA4", 
          "_T1VdwWitfALil_swkRRleOJMLZ-eZyKJSEYbYOV0wF_Ml34ZvxFo-qc6S7Y_fIB")
    client.authorize_from_access(omniauth['credentials']['token'],
                                 omniauth['credentials']['secret'])
    self.first_name = client.profile.first_name
    self.last_name = client.profile.last_name
    self.picture_url = client.profile.picture_url
  end
end
