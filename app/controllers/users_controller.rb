class UsersController < ApplicationController
  def index
    respond_with(current_user) 
  end
end
