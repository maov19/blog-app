class Api::UsersController < ApplicationController 
    def index
      @users = User.all
      respond_to do |format|
        format.json { render json: @users, status: :ok }
      end
    end
  end