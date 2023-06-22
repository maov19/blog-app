class Api::UsersController < ApplicationController
    def index
      @users = User.all
      respond_to do |format|
        format.json { render json: @users, status: :ok }
      end 
    end

    def show
      # Your code to fetch and return a specific user
    end
  
    def create
      # Your code to create a new user
    end
  
    def update
      # Your code to update a user
    end
  
    def destroy
      # Your code to delete a user
    end
  end
  