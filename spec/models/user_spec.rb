require 'spec_helper'

describe User do

  #create a test user before each spec
  before(:each) do
    @attr = { 
      :username => "Example User", 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance give valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    #use the Hash method "merge" to create an invalid user name
    no_name_user = User.new(@attr.merge(:username => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:username => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    # Put a user with the given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject addresses identical except for case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do
    
    it "should require a password" do
      #blank out password and password_confirmation
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      #change password_confirmation so that it does not match
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    #test that passwords are more than 5 chars
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    #test that passwords are less than 41 chars
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do
    #create a user object before each test
    before(:each) do
      @user = User.create!(@attr)
    end
    
    #check to see that the user object has an :encryped_passoword data element
    it "should have an encrypted password attribute" do
      @user.should respond_to(:crypted_password)
    end

    #check to ensure that the encrypted password is set in the db
    it "should set the encrypted password" do
      @user.crypted_password.should_not be_blank
    end
  end # describe "password encryption"

  describe "admin attribute" do
    
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end # describe "admin attribute"
end # describe User
