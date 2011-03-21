require 'spec_helper'

describe HvpElement do

  before (:each) do
    @hvp = Factory(:user).hartman_value_profiles.create!( 
                                    :taken_at => DateTime.now )
    @attr = {
      :axiological_norm => 1,
      :given_score => 1,
      :part => "self",
      :category => "intrinsic"
    }
  end

  it "should create a new element given valid attributes" do
    @hvp.hvp_elements.create!(@attr)
  end

  describe "hvp associations" do

    before(:each) do
      @hvp_element = @hvp.hvp_elements.create(@attr)
    end

    it "should have a hartman value profile attribute" do
      @hvp_element.should respond_to(:hartman_value_profile)
    end

    it "should have the right associated hartman value profile" do
      @hvp_element.hartman_value_profile_id.should == 
        @hvp.id
      @hvp_element.hartman_value_profile.should == @hvp
    end
  end # "hvp associations"
end
