module ApplicationHelper

  #Define a "logo" helper function
  def logo
    logo = image_tag("logo.png", :alt => "HighR", :class => "round")
  end

  #Define a "homepage_logo" helper function
  def home_logo
    home_logo = image_tag("home_logo.gif", 
                          :alt => "Homepage Logo", 
                          :class => "round")
  end
  
  #Define a "navigation_button" helper function
  def navigation_button image
    navigation_button = image_tag(image, :size => "195x59")
  end

  #Return a title on a per-page basis.
  def title
    base_title = "HighR"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
