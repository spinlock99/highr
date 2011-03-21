require 'spec_helper'

describe HartmanValueProfile do
  
  before (:each) do
    @user = Factory(:user)
    @attr = { :taken_at => DateTime.now }
  end

  it "should create a new profile given valid attributes" do
    @user.hartman_value_profiles.create!(@attr)
  end

  describe "associations" do
    
    before(:each) do
      @hvp = @user.hartman_value_profiles.create(@attr)
      @hvp_element1 = Factory(:hvp_element, :hartman_value_profile => @hvp,
                              :axiological_norm => 1,
                              :given_score => 2)
      @hvp_element2 = Factory(:hvp_element, :hartman_value_profile => @hvp,
                              :axiological_norm => 2,
                              :given_score => 1)
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
end
