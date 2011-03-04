class UsersController < ApplicationController
  def new
    @title = "Sign up"
  end

  def login
    @title = "Sign in"
  end
end
