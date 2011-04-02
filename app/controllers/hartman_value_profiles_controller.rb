class HartmanValueProfilesController < ApplicationController
  before_filter :authenticate_user!

  def new
    # assign the text for the title
    @title = "New Hartman Value Profile"
    
    # create a new hartman value profile for this user
    @hvp = HartmanValueProfile.new(current_user)
  end

  def create
    # create the hartman value profile
    @hvp = current_user.hartman_value_profiles.create do |hvp|
      hvp.taken_at = DateTime.now
    end
    # get the questions for part1
    @hvp_masters = HvpMaster.where("part_id = 'world'")
    @hvp_masters.each do |hvp_master|
      @hvp_element = @hvp.hvp_elements.create do |hvp_element|
        hvp_element.phrase = hvp_master.phrase
        hvp_element.axiological_norm = hvp_master.axiological_norm
        hvp_element.part_id = hvp_master.part_id
        hvp_element.category_id = hvp_master.category_id
      end
      @hvp_element.save!
    end
    if @hvp.save!
      session[:hvp_id] = @hvp.id
      flash[:success] = "Part 1"
      redirect_to get_part1_hartman_value_profile_path(@hvp)
    else
      @title = "Hartman Value Profile"
      render :new
    end
  end

  def get_part1
    @title = "Hartman Value Profile - Part 1"
    @hvp = HartmanValueProfile.find_by_id(session[:hvp_id])
  end

  def put_part1
    # save the results from part1
    @hvp = HartmanValueProfile.find_by_id(session[:hvp_id])
    @hvp.update_attributes(params[:hartman_value_profile])
    
    # set up the questions for part2
    @hvp_masters = HvpMaster.where("part_id = 'self'")
    @hvp_masters.each do |hvp_master|
      @hvp_element = @hvp.hvp_elements.create do |hvp_element|
        hvp_element.phrase = hvp_master.phrase
        hvp_element.axiological_norm = hvp_master.axiological_norm
        hvp_element.part_id = hvp_master.part_id
        hvp_element.category_id = hvp_master.category_id
      end
      @hvp_element.save!
    end
    if @hvp.save
      session[:hvp_id] = @hvp.id
      flash[:success] = "Part 2"
      redirect_to get_part2_hartman_value_profile_path(@hvp)
    else
      @title = "Hartman Value Profile"
      render :new
    end    
  end

  def get_part2
    @title = "Hartman Value Profile - Part 2"
    @hvp = HartmanValueProfile.find_by_id(session[:hvp_id])
  end

  def put_part2
    @hvp = HartmanValueProfile.find_by_id(session[:hvp_id])
    @hvp.update_attributes(params[:hartman_value_profile])
    @hvp.score_profile

    if @hvp.save
      flash[:success] = "Hartman Value Profile Completed"
      redirect_to current_user
    else
      # TODO: figure out a better way to handle this error.
      flash[:error] = "There was a problem saving the test"
      redirect_to :root
    end
  end
end
