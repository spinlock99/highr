class ApplicationController < ActionController::Base
  # harden the site against cross sight scripting attckes, etc...
  protect_from_forgery
  
  # make the authentication methods in the 
  # SessionsHelper available in contollers
  include UserSessionsHelper
end
