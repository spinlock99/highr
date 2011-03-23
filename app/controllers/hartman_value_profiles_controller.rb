class HartmanValueProfilesController < ApplicationController
  
  def new
    # assign the text for the title
    @title = "New Hartman Value Profile"
    
    # create a new hartman value profile for this user
    @hvp = HartmanValueProfile.new(current_user)
  end

  def create
    @hvp = current_user.hartman_value_profiles.create do |hvp|
      hvp.taken_at = DateTime.now
    end
    @hvp_masters = HvpMaster.all
    logger.debug "\n\n\t @hvp_masters \n"
    logger.debug "\t#{@hvp_masters}\n"
    @hvp_masters.each do |hvp_master|
      @hvp_element = @hvp.hvp_elements.create do |hvp_element|
        hvp_element.given_value = 1
        hvp_element.axiological_norm = hvp_master.axiological_norm
        hvp_element.part_id = hvp_master.part_id
        hvp_element.category_id = hvp_master.category_id
      end
      @hvp_element.save
    end
    #
    # PICK UP HERE. 
    # @hvp.save is failing but I'm seeing a new hartman_value_profile 
    # record and hvp_elements put into the db
    #
    logger.debug "\n\n\t calling @hvp.save \n"
    if @hvp.save!
      logger.debug "\n\n\t @hvp.save succeeded \n"
      session[:hvp_id] = @hvp.id
      flash[:success] = "Part 1"
      redirect_to part1_hartman_value_profile_path(@hvp)
    else
      logger.debug "\n\n\t @hvp.save failed \n"
      @title = "Hartman Value Profile"
      render :new
    end
  end

  def part1
    @title = "Hartman Value Profile - Part 1"
    @hvp = HartmanValueProfile.find_by_id(session[:hvp_id])
    logger.debug @hvp.hvp_elements
  end

  def part2
    @title = "Hartman Value Profile - Part 2"
  end
end
