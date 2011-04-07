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

  describe "micropost associations" do
    
    before(:each) do 
      @user = User.create(@attr)
      @mp1 = Factory(:micropost, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:micropost, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end

    it "should have the right microposts in the right order" do
      @user.microposts.should == [@mp2, @mp1]
    end

    it "should destroy associated microposts" do
      @user.destroy
      [@mp1, @mp2].each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

    describe "validations" do
      
      it "should require a user id" do
        Micropost.new(@attr).should_not be_valid
      end

      it "should require nonblank content" do
        @user.microposts.build(:content => "").should_not be_valid
      end

    end # validations

    describe "team talk" do
      
      it "should have a team_talk" do
        @user.should respond_to(:team_talk)
      end

      it "should include the user's microposts" do
        @user.team_talk.includes(@mp1).should be_true
        @user.team_talk.includes(@mp2).should be_true
      end

      it "should not include different user's microposts" do
        mp3 = Factory(:micropost, 
                      :user => Factory(:user, :email => Factory.next(:email)))
        @user.team_talk.include?(mp3).should be_false
      end
    end # status feed
  end # micropost associations
end # describe User
