class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

  end

  def posts
    @user = User.find(params[:id])

  end

  def show_post
    @user = User.find(params[:id])

  end
end
