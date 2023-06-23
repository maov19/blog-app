class Api::UsersController < ApplicationController
##commit add api for users 
  def index
    @users = User.all
    respond_to do |format|
      format.json { render json: @users, status: :ok }
    end
  end
end
