# == Schema Information
# Schema version: 20110404201311
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
#  first_name           :string(255)
#  last_name            :string(255)
#  picture_url          :string(255)
#

#User model is a subclass of ActiveRecord::Base 
#and inherits all of it's methods.
class User < ActiveRecord::Base
  # crack is a simple json and xml parser
  require 'crack'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, 
  # :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Add associations to HVP and Authentications
  has_many :hartman_value_profiles
  has_many :authentications
  has_many :microposts, :dependent => :destroy

  has_many :memberships, :dependent => :destroy
  has_many :teams, :through => :memberships
 
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

  #
  # team_talk
  #
  def team_talk
#    Micropost.where("user_id = ?", id)
    Micropost.where('user_id' => team_mates)
  end

  #
  # team_mates
  #
  # Returns all users that are on teams with the current_user
  def team_mates
    User.joins(:memberships).
      where('memberships.team_id' => team_ids).
      where(['users.id != ?', self.id]).
      select('distinct users.*')
  end

  #
  # name
  #
  # Return an appropriate name given that we cannot be sure that a user
  # has set their first_name and last_name
  def name
    if first_name && last_name
      name = "#{first_name} #{last_name}"
    elsif first_name
      name = first_name
    else
      name = email
    end
  end

  def picture
    if picture_url
      picture = picture_url
    else
      picture = "http://lorempixum.com/200/200/people"
    end
  end
  #
  # member?
  #
  # Returns true if the user is a member of the team
  #
  def member?(team)
    memberships.find_by_team_id(team)
  end

  #
  # join!
  #
  # Will cause the user to become a member of the given team.
  #
  def join!(team)
    memberships.create!(:team_id => team.id)
  end

  #
  # leave!
  #
  # Will cause the user to leave the given team.
  #
  def leave!(team)
    memberships.find_by_team_id(team).destroy
  end

protected

  def build_linkedin(omniauth)
    client = LinkedIn::Client.new(
          "zpfoZeTY4UFhmGZ3s23jKbJ4ZSs4r2wwb40FwjLEuntcHdi6Tfsk19F1o1BZ1SA4", 
          "_T1VdwWitfALil_swkRRleOJMLZ-eZyKJSEYbYOV0wF_Ml34ZvxFo-qc6S7Y_fIB")
    client.authorize_from_access(omniauth['credentials']['token'],
                                 omniauth['credentials']['secret'])
    self.first_name = client.profile.first_name
    self.last_name = client.profile.last_name
    @picture_url = client.profile(:fields => %w(picture-url))
    self.picture_url = @picture_url.picture_url
  end
end
