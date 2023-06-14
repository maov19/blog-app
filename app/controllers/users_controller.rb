class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    # Placeholder for displaying user, bio, posts, comment counter, and likes counter
  end

  def posts
    # Placeholder for displaying user, posts, comments, comment counter, and likes counter
  end

  def show_post
    # Placeholder for displaying post, comments, comment counter, and likes counter
  end
end
