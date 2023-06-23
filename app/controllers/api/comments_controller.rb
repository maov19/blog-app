##commit create comment json api

class Api::CommentsController < ApplicationController
  before_action :authenticate_api_request, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    @user = @current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = @user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: @comment.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:text)
  end
end
