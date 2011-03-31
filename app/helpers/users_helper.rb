module UsersHelper
  
  #helper function to take in a user object and pass the right 
  #information to the gravatar_image_tag() function
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :class => 'gravatar', 
                       :gravatar => options)
  end
end
