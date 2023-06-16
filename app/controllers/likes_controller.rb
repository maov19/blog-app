class LikesController < ApplicationController
  def new
    @like = Like.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post: @post)
    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Like added successfully'
    else
      redirect_to user_post_path(@post.author, @post), notice: 'Failed to add like'
    end
  end
end