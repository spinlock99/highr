# == Schema Information
# Schema version: 20110309193320
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#

#User model is a subclass of ActiveRecord::Base 
#and inherits all of it's methods.
class User < ActiveRecord::Base
  #make password only exist in memory and will not be written
  #to the database
  attr_accessor :password

  #attributes accessible to outside users
  attr_accessible :username, :email, :password, :password_confirmation

  #validate that the name attribute is present in the user record
  validates :username, :presence => true,
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

  #Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence => true,
                       #password_confirmation created here
                       :confirmation => true,
                       #specify the length
                       :length => { :within => 6..40 }

  #call private function :encrypt_password() 
  #before saving the password in the db
  before_save :encrypt_password

  #Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    #compare encrypted_password with the encrypted version of 
    #submitted_password.
    crypted_password == encrypt(submitted_password)
  end

  def self.authenticate (email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    # use a ternary opperator to return user if 
    # authentication with salt is successful and
    # nil otherwise.
    (user && user.password_salt == cookie_salt) ? user : nil
  end

  #begin private functions
  private

  #function to encrypt passwords
  def encrypt_password
    #self refers to the object so that we don't create 
    #a variable "encrypted_password"
    self.password_salt = make_salt if new_record?
    self.crypted_password = encrypt(password)
  end

  #function to encrypt a string
  def encrypt(string)
    secure_hash("#{password_salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
end
