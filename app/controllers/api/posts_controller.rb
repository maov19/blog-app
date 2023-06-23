class Api::PostsController < ApplicationController
##commit add api for usr posts
  def index
    user = User.find(params[:user_id])
    posts = user.posts

    render json: posts, status: :ok
  end
end
