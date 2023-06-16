class LikesController < ApplicationController
    def new
      @like = Like.new
      @post = Post.find(params[:post_id])
    end
  
    def create
      @post = Post.find(params[:like][:post_id])
      @like = current_user.likes.build(post: @post)
      if @like.save
  