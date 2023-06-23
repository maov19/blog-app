class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment created successfully'
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to user_post_path(@comment.author), notice: 'Comment was deleted succesfully'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
