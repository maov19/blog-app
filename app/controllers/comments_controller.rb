class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_posts_path(@post.author, @post), notice: 'Comment created successfully'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
