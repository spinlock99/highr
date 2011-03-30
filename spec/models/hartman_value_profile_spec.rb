require 'spec_helper'

describe HartmanValueProfile do
  
  before (:each) do
    @user = Factory(:user)
    @attr = { :taken_at => DateTime.now }
  end

  it "should create a new profile given valid attributes" do
    # set taken_at inside of a block because it is not an accessible_attribute
    @user.hartman_value_profiles.create! do |hvp|
      hvp.taken_at = DateTime.now
    end
  end

  describe "associations" do
    
    before(:each) do
      @hvp = @user.hartman_value_profiles.create do |hvp|
        hvp.taken_at = DateTime.now
      end
      @hvp_element1 = Factory(:hvp_element, :hartman_value_profile => @hvp,
                              :axiological_norm => 1,
                              :given_value => 2)
      @hvp_element2 = Factory(:hvp_element, :hartman_value_profile => @hvp,
                              :axiological_norm => 2,
                              :given_value => 1)
    end
    
    describe "user associations" do
      
      it "should have a user attribute" do
        @hvp.should respond_to(:user)
      end
      
      it "should have the right associated user" do
        @hvp.user_id.should == @user.id
        @hvp.user.should == @user
      end
    end # "user associations"
    
    describe "hartman value profile associations" do
      
      it "should have a hvp_elements attribute" do
        @hvp.should respond_to(:hvp_elements)
      end

      it "should have the right hvp_elements" do
        @hvp.hvp_elements.should =~ [@hvp_element1, @hvp_element2]
      end
    end # "hartman value profile associations"
  end # "associations"

  describe "validations" do
    it "should require a user id" do
      HartmanValueProfile.new(@attr).should_not be_valid
    end

    it "should require taken_at to be non-blank" do
      @user.hartman_value_profiles.build(:taken_at => "").should_not be_valid
    end
  end # "validation"
end
