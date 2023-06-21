class PostsController < ApplicationController
  def index
    # @user = User.includes(posts: [:author, comments: :author]).find(params[:user_id])
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, comments: :author)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
  end

  def new
    @post = Post.new
  end

  def create
    @post = @current_user.posts.build(post_params)
    puts "Current User ID: #{current_user.id}"
    puts "New Post Author ID: #{@post.author_id}"
    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post created successfully'
    else
      puts @post.errors.full_messages # Debugging output to check validation errors
      redirect_to user_path(current_user), notice: 'Post not created'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
