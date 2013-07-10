class UsersController < ApplicationController
  def user
    respond_with(current_user) 
  end

  
end
