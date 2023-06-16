class CommentsController < ApplicationController
    def new
      @comment = Comment.new
    end
  
    def create
      @comment = current_user.comments.build(comment_params)
      if @comment.save
        redirect_to posts_path, notice: 'Comment created successfully'
      else
        render :new
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  