require 'spec_helper'

describe User do

  #create a test user before each spec
  before(:each) do
    @attr = { 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance give valid attributes" do
    User.create!(@attr)
  end

  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
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
      @user.should respond_to(:encrypted_password)
    end

    #check to ensure that the encrypted password is set in the db
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
  end # describe "password encryption"

  describe "hartman value profile associations" do
    
    before(:each) do
      @user = User.create(@attr)
      @hvp1 = Factory(:hartman_value_profile, :user => @user,
                      :taken_at => 1.week.ago)
      @hvp2 = Factory(:hartman_value_profile, :user => @user,
                      :taken_at => 1.day.ago)
    end
    
    it "should have a hartman_value_profiles attribute" do
      @user.should respond_to(:hartman_value_profiles)
    end

    it "should have the right hartman_value_profiles in the right order" do
      @user.hartman_value_profiles.should == [@hvp2, @hvp1]
    end
  end # "hartman value profile associations"
end # describe User
