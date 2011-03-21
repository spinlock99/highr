require 'spec_helper'

describe HvpElement do

  before (:each) do
    @hvp = Factory(:user).hartman_value_profiles.create do |hvp|
      hvp.taken_at = DateTime.now
    end
    @attr = {
      :axiological_norm => "1",
      :given_value => "1",
      :part_id => "self",
      :category_id => "intrinsic"
    }
  end
  
  it "should create a new element given valid attributes" do
    @hvp.hvp_elements.create! do |hvp_element|
      hvp_element.axiological_norm = 1
      hvp_element.given_value = 1
      hvp_element.part_id = "self"
      hvp_element.category_id = "intrinsic"
    end
# the next line will fail and print out the hvp_elements
#    @hvp.hvp_elements.should eq( "sucka" )
  end

  describe "hvp associations" do

    before(:each) do
      @hvp_element = Factory(:hvp_element, :hartman_value_profile => @hvp)
    end

#    it "should show the element" do
#      @hvp_element.should eq( "stuff" )
#    end
#    it "should show the attributes" do
#      @attr.should eq( "stuff" )
#    end

    it "should have a hartman value profile attribute" do
      @hvp_element.should respond_to(:hartman_value_profile)
    end

    it "should have the right associated hartman value profile" do
      @hvp_element.hartman_value_profile_id.should == 
        @hvp.id
      @hvp_element.hartman_value_profile.should == @hvp
    end
  end # "hvp associations"

  describe "validations" do
    
    before(:each) do
      @hvp_element = Factory(:hvp_element, :hartman_value_profile => @hvp)
    end

    it "should require a hartman value profile id" do
      HvpElement.new(@attr).should_not be_valid
    end

    it "should require axiological norm to be present" do
      @hvp_element.axiological_norm = nil
      @hvp_element.should_not be_valid
    end

    it "should require axiological norm to be in the correct range" do
#      @hvp.hvp_elements.build(:axiological_norm => 1).should be_valid
      @hvp_element.axiological_norm = 0
      @hvp_element.should_not be_valid
#      @hvp_element.should eq ("sucka")
    end

    it "should require axiological norm to be in the correct range" do
#      @hvp.hvp_elements.build(:axiological_norm => "19").should_not be_valid
      @hvp_element.axiological_norm = 19
      @hvp_element.should_not be_valid
    end

    it "should require given_value to be present" do
#      @hvp.hvp_elements.build(:given_value => "").should_not be_valid
      @hvp_element.given_value = "" 
      @hvp_element.should_not be_valid
    end

    it "should require given_value to be greater than or equal to 1" do
#      @hvp.hvp_elements.build(:given_value => "0").should_not be_valid
      @hvp_element.given_value = 0
      @hvp_element.should_not be_valid
    end

    it "should require given_value to be less than or equal to 18" do
#      @hvp.hvp_elements.build(:given_value => "19").should_not be_valid
      @hvp_element.given_value = 19
      @hvp_element.should_not be_valid
    end

    it "should have a part_id" do
      @hvp_element.part_id = ""
      @hvp_element.should_not be_valid
    end

    it "should require part_id to be in 'self' or 'world'" do
      @hvp_element.part_id = "sucka"
      @hvp_element.should_not be_valid
    end

    it "should have a category_id" do
      @hvp_element.category_id = ""
      @hvp_element.should_not be_valid
    end

    it "should require category_id to be in 'intrinsic', 'extrinsic', or 'systemic'" do
      @hvp_element.category_id = "sucka"
      @hvp_element.should_not be_valid
    end
  end # "validations"
end
